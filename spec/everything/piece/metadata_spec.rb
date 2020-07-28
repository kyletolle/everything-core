require './spec/support/pieces'

describe Everything::Piece::Metadata do
  let(:metadata) do
    described_class.new(fake_piece_path)
  end

  describe '#[]' do
    include_context 'with fake piece'

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

  describe '#absolute_dir' do
    include_context 'with fake piece metadata'

    let(:metadata_absolute_dir) do
      '/fake/everything/path/grond-crawled-on'
    end
    it "returns the metadata's absolute path" do
      expect(metadata.absolute_dir).to eq(metadata_absolute_dir)
    end

    it 'memoizes the value' do
      first_call_result = metadata.absolute_dir
      second_call_result = metadata.absolute_dir
      expect(first_call_result.object_id).to eq(second_call_result.object_id)
    end
  end

  describe '#absolute_path' do
    include_context 'with fake piece metadata'

    let(:metadata_absolute_path) do
      '/fake/everything/path/grond-crawled-on/index.yaml'
    end
    it "returns the metadata's absolute path" do
      expect(metadata.absolute_path).to eq(metadata_absolute_path)
    end

    it 'memoizes the value' do
      first_call_result = metadata.absolute_path
      second_call_result = metadata.absolute_path
      expect(first_call_result.object_id).to eq(second_call_result.object_id)
    end
  end

  describe '#dir' do
    include_context 'with fake piece metadata'

    let(:metadata_dir_relative_to_everything_path) do
      'grond-crawled-on'
    end
    it "returns the metadata's path relative to everything path" do
      expect(metadata.dir).to eq(metadata_dir_relative_to_everything_path)
    end

    it 'memoizes the value' do
      first_dir_value = metadata.dir
      second_dir_value = metadata.dir
      expect(first_dir_value.object_id).to eq(second_dir_value.object_id)
    end
  end

  describe '#file_path' do
    include_context 'with fake piece'

    let(:expected_file_path) do
      "#{fake_piece_path}/index.yaml"
    end

    it 'is the index.yaml under the piece' do
      expect(metadata.file_path).to eq(expected_file_path)
    end
  end

  describe '#path' do
    include_context 'with fake piece metadata'

    let(:metadata_path_relative_to_everything_path) do
      'grond-crawled-on/index.yaml'
    end

    it "returns the metadata's path relative to everything path" do
      expect(metadata.path).to eq(metadata_path_relative_to_everything_path)
    end

    it 'memoizes the value' do
      first_path_value = metadata.path
      second_path_value = metadata.path
      expect(first_path_value.object_id).to eq(second_path_value.object_id)
    end
  end

  describe '#raw_yaml' do
    include_context 'with fake piece metadata'

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
    include_context 'with fake piece'

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
    include_context 'with fake piece'

    before do
      FakeFS.activate!

      metadata.raw_yaml = <<YAML
---
favorite_color: blue
YAML
    end

    after do
      FileUtils.rm_rf(fake_piece_path)

      FakeFS.deactivate!
    end

    context 'when the piece directory does not exist' do
      before do
        FileUtils.rm_rf(fake_piece_path)
      end

      it 'creates the folder' do
        expect(Dir.exist?(fake_piece_path)).to eq(false)

        metadata.save

        expect(Dir.exist?(fake_piece_path)).to eq(true)
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
