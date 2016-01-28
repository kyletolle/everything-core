describe Everything::Piece do
  let(:given_full_path) do
    'some/fake/path/here'
  end
  let(:piece) do
    described_class.new(given_full_path)
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
        .with(given_full_path)

      piece.content
    end
  end

  describe '#full_path' do
    it "returns the piece's full path" do
      expect(piece.full_path).to eq(given_full_path)
    end
  end

  describe '#metadata' do
    it 'is an instance of Metadata' do
      expect(piece.metadata).to be_a(Everything::Piece::Metadata)
    end

    it "is created with the piece's full path" do
      expect(Everything::Piece::Metadata)
        .to receive(:new)
        .with(given_full_path)

      piece.metadata
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

  describe '#title' do
    include_context 'with content double'

    it 'delegates to the content' do
      allow(content_double).to receive(:title)

      piece.title

      expect(content_double).to have_received(:title)
    end
  end
end
