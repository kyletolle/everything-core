describe Everything::Piece do
  include_context 'with fake everything path env var'
  include_context 'with fake piece'

  let(:piece) do
    described_class.new(fake_piece_path)
  end

  shared_context 'with content double' do
    let(:content_double) do
      instance_double(Everything::Piece::Content)
    end

    before do
      allow(Everything::Piece::Content)
        .to receive(:new)
        .and_return(content_double)
    end
  end

  shared_context 'with metadata double' do
    let(:metadata_double) do
      instance_double(Everything::Piece::Metadata)
    end

    before do
      allow(Everything::Piece::Metadata)
        .to receive(:new)
        .and_return(metadata_double)
    end
  end

  describe '#absolute_dir' do
    include_context 'with content double'

    it 'delegates to the content' do
      allow(content_double).to receive(:absolute_dir)

      piece.absolute_dir

      expect(content_double).to have_received(:absolute_dir)
    end
  end

  describe '#absolute_path' do
    include_context 'with content double'

    it 'delegates to the content' do
      allow(content_double).to receive(:absolute_path)

      piece.absolute_path

      expect(content_double).to have_received(:absolute_path)
    end
  end

  describe '#body' do
    include_context 'with content double'

    it 'delegates to the content' do
      allow(content_double).to receive(:body)

      piece.body

      expect(content_double).to have_received(:body)
    end
  end

  describe '#content' do
    it 'is an instance of Content' do
      expect(piece.content).to be_a(Everything::Piece::Content)
    end

    it "is created with the piece's full path" do
      expect(Everything::Piece::Content)
        .to receive(:new)
        .with(fake_piece_path)

      piece.content
    end
  end

  describe '#dir' do
    include_context 'with content double'

    it 'delegates to the content' do
      allow(content_double).to receive(:dir)

      piece.dir

      expect(content_double).to have_received(:dir)
    end
  end

  describe '#file_name' do
    include_context 'with content double'

    it 'delegates to the content' do
      allow(content_double).to receive(:file_name)

      piece.file_name

      expect(content_double).to have_received(:file_name)
    end
  end

  describe '#full_path' do
    it "returns the piece's full path" do
      expect(piece.full_path).to eq(fake_piece_path)
    end
  end

  describe '#metadata' do
    it 'is an instance of Metadata' do
      expect(piece.metadata).to be_a(Everything::Piece::Metadata)
    end

    it "is created with the piece's full path" do
      expect(Everything::Piece::Metadata)
        .to receive(:new)
        .with(fake_piece_path)

      piece.metadata
    end
  end

  describe '#name' do
    let(:expected_name) do
      'grond-crawled-on'
    end

    it 'is the last part of the path' do
      expect(piece.name).to eq(expected_name)
    end

    it 'memoizes the value' do
      first_name_value = piece.name
      second_name_value = piece.name
      expect(first_name_value.object_id).to eq(second_name_value.object_id)
    end
  end

  describe '#path' do
    include_context 'with content double'

    it 'delegates to the content' do
      allow(content_double).to receive(:path)

      piece.path

      expect(content_double).to have_received(:path)
    end
  end

  describe '#public?' do
    let(:metadata_double) do
      instance_double(Everything::Piece::Metadata)
    end

    it "returns the metadata's public value" do
      allow(Everything::Piece::Metadata)
        .to receive(:new)
        .and_return(metadata_double)

      expect(metadata_double)
        .to receive(:[])
        .with('public')
        .and_return(false)

      expect(piece.public?).to eq(false)
    end
  end

  describe '#raw_markdown' do
    include_context 'with content double'

    it 'delegates to the content' do
      allow(content_double).to receive(:raw_markdown)

      piece.raw_markdown

      expect(content_double).to have_received(:raw_markdown)
    end
  end

  describe '#raw_markdown=' do
    include_context 'with content double'

    it 'delegates to the content' do
      allow(content_double).to receive(:raw_markdown=)

      piece.raw_markdown=("# Test markdown")

      expect(content_double)
        .to have_received(:raw_markdown=)
        .with("# Test markdown")
    end
  end

  describe '#title' do
    include_context 'with content double'

    it 'delegates to the content' do
      allow(content_double).to receive(:title)

      piece.title

      expect(content_double).to have_received(:title)
    end
  end

  describe '#raw_yaml' do
    include_context 'with metadata double'

    it 'delegates to the metadata' do
      allow(metadata_double).to receive(:raw_yaml)

      piece.raw_yaml

      expect(metadata_double).to have_received(:raw_yaml)
    end
  end

  describe '#raw_yaml=' do
    include_context 'with metadata double'

    it 'delegates to the metadata' do
      allow(metadata_double).to receive(:raw_yaml=)

      piece.raw_yaml=("---\nanything: works")

      expect(metadata_double)
        .to have_received(:raw_yaml=)
        .with("---\nanything: works")
    end
  end

  describe '#save' do
    include_context 'with content double'
    include_context 'with metadata double'

    before do
      allow(content_double).to receive(:save)
      allow(metadata_double).to receive(:save)
    end

    it 'calls save on the content' do
      piece.save

      expect(content_double)
        .to have_received(:save)
    end

    it 'calls save on the metadata' do
      piece.save

      expect(metadata_double)
        .to have_received(:save)
    end
  end
end

