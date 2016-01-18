describe Everything do
  it 'has a version number' do
    expect(Everything::VERSION).not_to be nil
  end

  describe '.path' do
    let(:expected_path) do
      '/some/path/to/your/everything/repo/'
    end

    before do
      ENV['EVERYTHING_PATH'] = expected_path
    end

    it 'is the path from the environment' do
      expect(described_class.path).to eq(expected_path)
    end
  end
end
