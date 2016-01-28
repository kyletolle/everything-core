describe Everything::Piece::Content do
  shared_context 'with tmp piece on disk' do
    let!(:tmp_piece_path) do
      Dir.mktmpdir
    end

    after do
      # This will recursively remove everything under that tmp dir.
      FileUtils.remove_entry(tmp_piece_path)
    end
  end

  shared_context 'with tmp piece markdown file on disk' do
    let(:tmp_piece_markdown_path) do
      File.join(tmp_piece_path, 'index.md')
    end

    let(:given_markdown) do
      <<MD
# Piece Title Here

The content is totally this right here.

And it might even include multiple lines!
MD
    end

    before do
      File.open(tmp_piece_markdown_path, 'w') do |markdown_file|
        markdown_file.puts given_markdown
      end
    end
  end

  let(:content) do
    described_class.new(tmp_piece_path)
  end

  describe "#file_path" do
    include_context 'with tmp piece on disk'

    let(:expected_file_path) do
      "#{tmp_piece_path}/index.md"
    end

    it 'is the index.md under the piece' do
      expect(content.file_path).to eq(expected_file_path)
    end
  end

  describe '#title' do
    include_context 'with tmp piece on disk'
    include_context 'with tmp piece markdown file on disk'

    let(:expected_title) do
      'Piece Title Here'
    end

    it 'is the title from the markdown' do
      expect(content.title).to eq(expected_title)
    end
  end

  describe '#body' do
    include_context 'with tmp piece on disk'
    include_context 'with tmp piece markdown file on disk'

    let(:expected_body) do
    <<MD
The content is totally this right here.

And it might even include multiple lines!
MD
    end

    it 'is the body text from the markdown' do
      expect(content.body).to eq(expected_body)
    end
  end

  describe '#raw_markdown' do
    include_context 'with tmp piece on disk'
    include_context 'with tmp piece markdown file on disk'

    let(:expected_raw_markdown) do
      given_markdown
    end

    it 'is the markdown from the file' do
      expect(content.raw_markdown).to eq(expected_raw_markdown)
    end

    it 'memoizes the file read' do
      allow(File)
        .to receive(:read)
        .and_call_original

      content.raw_markdown
      content.raw_markdown

      expect(File)
        .to have_received(:read)
        .exactly(:once)
    end
  end
end
