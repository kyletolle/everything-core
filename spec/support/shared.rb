shared_context 'with fake everything path env var' do
  let(:fake_everything_path) do
    '/fake/everything/path/'
  end

  before do
    without_partial_double_verification do
      allow(Fastenv)
        .to receive(:everything_path)
        .and_return(fake_everything_path)
    end
  end
end
