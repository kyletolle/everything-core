require 'tmpdir'
require 'fileutils'

RSpec.shared_context 'with fake piece' do
  include_context 'with fake everything path'

  let(:given_piece_name) do
    'grond-crawled-on'
  end
  let(:fake_piece_path) do
    File.join(Everything.path, given_piece_name)
  end

  before do
    FileUtils.mkdir_p(fake_piece_path)
  end

  # Folder will get cleaned up by fake everything path
end

RSpec.shared_context 'with fake piece content' do
  include_context 'with fake piece'

  let(:fake_piece_content_file_path) do
    File.join(fake_piece_path, 'index.md')
  end

  let(:given_markdown) do
    <<MD
# Piece Title Here

The body is totally this right here.

And it might even include multiple lines!
MD
  end

  before do
    File.write(fake_piece_content_file_path, given_markdown)
  end

  # File will get cleaned up by fake everything path
end

RSpec.shared_context 'with fake piece metadata' do
  include_context 'with fake piece'

  let(:fake_piece_metadata_file_path) do
    File.join(fake_piece_path, 'index.yaml')
  end

  let(:given_yaml) do
    <<YAML
---
public: false
YAML
  end

  before do
    File.write(fake_piece_metadata_file_path, given_yaml)
  end

  # File will get cleaned up by fake everything path
end

