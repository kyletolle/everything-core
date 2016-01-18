describe Everything::Piece do
  let(:given_full_path) do
    'some/fake/path/here'
  end
  let(:piece) do
    described_class.new(given_full_path)
  end
  let(:expected_markdown_file_path) do
    "#{given_full_path}/index.md"
  end
  let(:fake_markdown_text) do
<<MD
# Piece Title Here

The content is totally this right here.

And it might even include multiple lines!
MD
  end

  shared_context 'with fake markdown file' do
    before do
      expect(File)
        .to receive(:read)
        .with(expected_markdown_file_path)
        .and_return(fake_markdown_text)
    end
  end

  describe '#content' do
    include_context 'with fake markdown file'

    let(:expected_content) do
<<TEXT
The content is totally this right here.

And it might even include multiple lines!
TEXT
    end

    it 'is only the markdown after the title' do
      expect(piece.content).to eq(expected_content)
    end
  end

  describe '#full_path' do
    it "returns the piece's full path" do
      expect(piece.full_path).to eq(given_full_path)
    end
  end

  describe '#raw_markdown' do
    include_context 'with fake markdown file'

    let(:expected_raw_markdown) do
      fake_markdown_text
    end

    it "is all the file's markdown" do
      expect(piece.raw_markdown).to eq(expected_raw_markdown)
    end
  end

  describe '#title' do
    include_context 'with fake markdown file'

    let(:expected_title) do
      'Piece Title Here'
    end

    it 'is text of the markdown title' do
      expect(piece.title).to eq(expected_title)
    end
  end
end
