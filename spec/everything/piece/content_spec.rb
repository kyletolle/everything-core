require 'fakefs/spec_helpers'
require './spec/support/pieces'

describe Everything::Piece::Content do
  include_context 'with fake piece'

  let(:content) do
    described_class.new(fake_piece_path)
  end

  describe '#absolute_dir' do
    let(:content_absolute_dir) do
      Pathname.new('/fake/everything/path/grond-crawled-on')
    end

    it "returns the content's absolute path" do
      expect(content.absolute_dir).to eq(content_absolute_dir)
    end

    it 'memoizes the value' do
      first_call_result = content.absolute_dir
      second_call_result = content.absolute_dir
      expect(first_call_result.object_id).to eq(second_call_result.object_id)
    end
  end

  describe '#absolute_path' do
    let(:content_absolute_path) do
      Pathname.new('/fake/everything/path/grond-crawled-on/index.md')
    end

    it "returns the content's absolute path" do
      expect(content.absolute_path).to eq(content_absolute_path)
    end

    it 'memoizes the value' do
      first_call_result = content.absolute_path
      second_call_result = content.absolute_path
      expect(first_call_result.object_id).to eq(second_call_result.object_id)
    end
  end

  describe '#dir' do
    let(:content_dir_relative_to_everything_path) do
      Pathname.new('grond-crawled-on')
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

  describe '#path' do
    let(:content_path_relative_to_everything_path) do
      Pathname.new('grond-crawled-on/index.md')
    end

    it "returns the content's path relative to everything path" do
      expect(content.path).to eq(content_path_relative_to_everything_path)
    end

    it 'memoizes the value' do
      first_path_value = content.path
      second_path_value = content.path
      expect(first_path_value.object_id).to eq(second_path_value.object_id)
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
      allow(content.absolute_path)
        .to receive(:read)
        .and_call_original

      2.times { content.raw_markdown }

      expect(content.absolute_path)
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
        expect(fake_piece_path).not_to exist

        content.save

        expect(fake_piece_path).to exist
      end

      it 'creates the content markdown file' do
        expect(content.absolute_path).not_to exist

        content.save

        expect(content.absolute_path).to exist
      end

      it 'writes the markdown to the file' do
        content.save

        expect(content.absolute_path.read).to eq('# Ship Shape')
      end
    end

    context 'when the piece directory exists' do
      context 'when the content file does not exist' do
        it 'creates the content markdown file' do
          expect(content.absolute_path).not_to exist

          content.save

          expect(content.absolute_path).to exist
        end

        it 'writes the markdown to the file' do
          content.save

          expect(content.absolute_path.read).to eq('# Ship Shape')
        end
      end

      context 'when the content file already exists' do
        before do
          content.absolute_path.write('# Rolly Polly')
        end

        it 'overwrites the file with the correct markdown' do
          content.save

          expect(content.absolute_path.read).to eq('# Ship Shape')
        end
      end
    end
  end
end

