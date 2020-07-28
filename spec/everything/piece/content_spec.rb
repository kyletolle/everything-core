require 'fakefs/spec_helpers'
require './spec/support/pieces'

describe Everything::Piece::Content do
  include_context 'with fake piece'

  let(:content) do
    described_class.new(fake_piece_path)
  end

  describe '#dir' do
    let(:content_dir_relative_to_everything_path) do
      'grond-crawled-on'
    end
    it "returns the content's path relative to everything path" do
      expect(content.dir).to eq(content_dir_relative_to_everything_path)
    end

    it 'memoizes the value' do
      first_dir_value = content.dir
      second_dir_value = content.dir
      expect(first_dir_value.object_id).to eq(second_dir_value.object_id)
    end
  end

  describe '#file_name' do
    let(:expected_file_name) do
      'index.md'
    end

    it 'is the markdown file according to everything convention' do
      expect(content.file_name).to eq(expected_file_name)
    end
  end

  describe '#file_path' do
    let(:expected_file_path) do
      "#{fake_piece_path}/index.md"
    end

    it 'is the index.md under the piece' do
      expect(content.file_path).to eq(expected_file_path)
    end
  end

  describe '#title' do
    include_context 'with fake piece content'

    let(:expected_title) do
      'Piece Title Here'
    end

    it 'is the title from the markdown' do
      expect(content.title).to eq(expected_title)
    end
  end

  describe '#body' do
    include_context 'with fake piece content'

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
    include_context 'with fake piece content'

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
    before do
      FakeFS.activate!

      content.raw_markdown = "# Ship Shape"
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

        content.save

        expect(Dir.exist?(fake_piece_path)).to eq(true)
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

