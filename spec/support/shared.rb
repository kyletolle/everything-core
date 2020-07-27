shared_context 'with fake everything path env var' do
  before do
    without_partial_double_verification do
      allow(Fastenv)
        .to receive(:everything_path)
        .and_return(expected_path)
    end
  end
end
