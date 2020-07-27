describe Everything do
  it 'has a version number' do
    expect(Everything::VERSION).not_to be nil
  end

  describe '.path' do
    let(:expected_path) do
      '/some/path/to/your/everything/repo/'
    end

    before do
      without_partial_double_verification do
        allow(Fastenv)
          .to receive(:everything_path)
          .and_return(expected_path)
      end
    end

    it 'is a pathname' do
      expect(described_class.path).to be_a_kind_of(Pathname)
    end

    it 'is the path from the environment' do
      expect(described_class.path.to_s).to eq(expected_path)
    end
  end
end
