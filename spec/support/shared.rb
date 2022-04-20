RSpec.shared_context 'with fake everything path env var' do
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

RSpec.shared_context 'with fakefs' do
  before do
    FakeFS.activate!
  end

  after do
    FakeFS.deactivate!
  end
end

RSpec.shared_context 'with fake everything path' do
  include FakeFS::SpecHelpers

  include_context 'with fake everything path env var'
  include_context 'with fakefs'

  before do
    FileUtils.mkdir_p(fake_everything_path)
  end

  after do
    FileUtils.rm_rf(fake_everything_path)
  end
end

