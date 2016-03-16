require './spec/support/pieces'

describe Everything::Piece::Content do
  shared_context 'with tmp piece markdown file on disk' do
    let(:tmp_piece_markdown_path) do
      File.join(tmp_piece_path, 'index.md')
    end

    let(:given_markdown) do
      <<MD
# Piece Title Here

The body is totally this right here.

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

  describe '#file_path' do
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
The body is totally this right here.

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

      2.times { content.raw_markdown }

      expect(File)
        .to have_received(:read)
        .exactly(:once)
    end
  end

  describe '#raw_markdown=' do
    include_context 'with tmp piece on disk'

    let(:new_raw_markdown) do
      <<MD
# New Markdown

This is a completely new bit of markdown.
MD
    end

    it 'sets the raw_markdown value' do
      content.raw_markdown = new_raw_markdown

      expect(content.raw_markdown).to eq(new_raw_markdown)
    end
  end

  describe '#save' do
    let(:tmp_dir) do
      Dir.tmpdir
    end

    let(:tmp_piece_path) do
      File.join(tmp_dir, 'a-test-piece')
    end

    before do
      content.raw_markdown = "# Ship Shape"
    end

    after do
      FileUtils.remove_entry(tmp_piece_path)
    end

    context 'when the piece directory does not exist' do
      it 'creates the folder' do
        expect(Dir.exist?(tmp_piece_path)).to eq(false)

        content.save

        expect(Dir.exist?(tmp_piece_path)).to eq(true)
      end

      it 'creates the content markdown file' do
        expect(File.exist?(content.file_path)).to eq(false)

        content.save

        expect(File.exist?(content.file_path)).to eq(true)
      end

      it 'writes the markdown to the file' do
        content.save

        expect(File.read(content.file_path)).to eq('# Ship Shape')
      end
    end

    context 'when the piece directory exists' do
      before do
        FileUtils.mkdir_p(tmp_piece_path)
      end

      context 'when the content file does not exist' do
        it 'creates the content markdown file' do
          expect(File.exist?(content.file_path)).to eq(false)

          content.save

          expect(File.exist?(content.file_path)).to eq(true)
        end

        it 'writes the markdown to the file' do
          content.save

          expect(File.read(content.file_path)).to eq('# Ship Shape')
        end
      end

      context 'when the content file already exists' do
        before do
          File.write(content.file_path, '# Rolly Polly')
        end

        it 'overwrites the file with the correct markdown' do
          content.save

          expect(File.read(content.file_path)).to eq('# Ship Shape')
        end
      end
    end
  end
end
