require './spec/support/pieces'

describe Everything::Piece::Metadata do
  shared_context 'with tmp piece metadata file on disk' do
    let(:tmp_piece_metadata_path) do
      File.join(tmp_piece_path, 'index.yaml')
    end

    let(:given_yaml) do
      <<YAML
---
public: false
YAML
    end

    before do
      File.open(tmp_piece_metadata_path, 'w') do |metadata_file|
        metadata_file.puts given_yaml
      end
    end
  end

  let(:metadata) do
    described_class.new(tmp_piece_path)
  end

  describe '#[]' do
    include_context 'with tmp piece on disk'

    let(:yaml_double) do
      instance_double(Hash)
    end
    let(:given_key) { 'public' }

    before do
      expect(YAML)
        .to receive(:load_file)
        .and_return(yaml_double)
    end

    it 'delegates to the yaml' do
      allow(yaml_double)
        .to receive(:[])

      metadata[given_key]

      expect(yaml_double)
        .to have_received(:[])
        .with(given_key)
    end
  end

  describe '#file_path' do
    include_context 'with tmp piece on disk'

    let(:expected_file_path) do
      "#{tmp_piece_path}/index.yaml"
    end

    it 'is the index.yaml under the piece' do
      expect(metadata.file_path).to eq(expected_file_path)
    end
  end

  describe '#raw_yaml' do
    include_context 'with tmp piece on disk'
    include_context 'with tmp piece metadata file on disk'

    let(:expected_raw_yaml) do
      {
        'public' => false
      }
    end

    it 'is the yaml as parsed from the file' do
      expect(metadata.raw_yaml).to eq(expected_raw_yaml)
    end

    it 'memoizes the yaml read' do
      allow(YAML)
        .to receive(:load_file)
        .and_call_original

      metadata.raw_yaml
      metadata.raw_yaml

      expect(YAML)
        .to have_received(:load_file)
        .exactly(:once)
    end
  end

  describe '#raw_yaml=' do
    include_context 'with tmp piece on disk'

    let(:new_raw_yaml) do
      <<YAML
---
public: true
other: okay
YAML
    end

    it 'sets the raw_yaml value' do
      metadata.raw_yaml = new_raw_yaml

      expect(metadata.raw_yaml).to eq(new_raw_yaml)
    end
  end

  describe '#save' do
    let(:tmp_dir) do
      Dir.tmpdir
    end

    let(:tmp_piece_path) do
      File.join(tmp_dir, 'fake-piece-here')
    end

    before do
      metadata.raw_yaml = <<YAML
---
favorite_color: blue
YAML
    end

    after do
      FileUtils.remove_entry(tmp_piece_path)
    end

    context 'when the piece directory does not exist' do
      it 'creates the folder' do
        expect(Dir.exist?(tmp_piece_path)).to eq(false)

        metadata.save

        expect(Dir.exist?(tmp_piece_path)).to eq(true)
      end

      it 'creates the metadata yaml file' do
        expect(File.exist?(metadata.file_path)).to eq(false)

        metadata.save

        expect(File.exist?(metadata.file_path)).to eq(true)
      end

      it 'writes the yaml to the file' do
        metadata.save

        expect(File.read(metadata.file_path)).to eq(<<YAML)
---
favorite_color: blue
YAML
      end
    end

    context 'when the piece directory exists' do
      before do
        FileUtils.mkdir_p(tmp_piece_path)
      end

      context 'when the metadata file does not exist' do
        it 'creates the metadata yaml file' do
          expect(File.exist?(metadata.file_path)).to eq(false)

          metadata.save

          expect(File.exist?(metadata.file_path)).to eq(true)
        end

        it 'writes the yaml to the file' do
          metadata.save

          expect(File.read(metadata.file_path)).to eq(<<YAML)
---
favorite_color: blue
YAML
        end
      end

      context 'when the metadata file already exists' do
        before do
          File.write(metadata.file_path, "---\nwho: knows")
        end

        it 'overwrites the file with the correct yaml' do
          metadata.save

          expect(File.read(metadata.file_path)).to eq(<<YAML)
---
favorite_color: blue
YAML
        end
      end
    end
  end
end
