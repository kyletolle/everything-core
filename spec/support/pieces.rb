RSpec.shared_context 'with tmp piece on disk' do
  let!(:tmp_piece_path) do
    Dir.mktmpdir
  end

  after do
    # This will recursively remove everything under that tmp dir.
    FileUtils.remove_entry(tmp_piece_path)
  end
end
