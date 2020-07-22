require 'spec_helper'

describe Everything do
  after { Everything.logger = nil }

  describe '#logger' do
    context 'when a logger is not being overwritten' do
      context 'when a logger was previously set' do
        let(:test_logger) do
          instance_double(Logger)
        end

        before do
          Everything.logger = test_logger
        end

        it 'returns the previously given logger' do
          actual_logger = Everything.logger
          expect(actual_logger).to eq(test_logger)
        end

        it 'memoizes the value' do
          first_logger = Everything.logger
          second_logger = Everything.logger

          expect(first_logger.object_id).to eq(second_logger.object_id)
        end
      end

      context 'when a logger was not previously set' do
        it 'defaults to a Logger' do
          actual_logger = Everything.logger
          expect(actual_logger).to be_a_kind_of(::Logger)
        end

        it 'memoizes the value' do
          first_logger = Everything.logger
          second_logger = Everything.logger

          expect(first_logger.object_id).to eq(second_logger.object_id)
        end
      end
    end

    context 'when a logger is being overwritten' do
      let(:original_logger) do
        instance_double(Logger)
      end
      let(:new_logger) do
        instance_double(Logger)
      end

      before do
        Everything.logger = original_logger
      end

      context 'with a new logger' do
        before do
          Everything.logger = new_logger
        end

        it 'is not the original logger' do
          expect(Everything.logger).not_to eq(original_logger)
        end

        it 'is the new logger' do
          expect(Everything.logger).to eq(new_logger)
        end
      end
    end
  end

  describe '#logger=' do
    let(:test_logger) do
      instance_double(Logger)
    end

    it 'stores the value passed in' do
      Everything.logger = test_logger

      expect(Everything.logger).to eq(test_logger)
    end
  end

  describe '#default_logger' do
    let(:actual_default_logger) do
      Everything.default_logger
    end

    it 'is a Logger' do
      expect(actual_default_logger).to be_a_kind_of(::Logger)
    end

    it 'will log to stdout' do
      expect(::Logger)
        .to receive(:new)
        .with($stdout, anything)

      actual_default_logger
    end

    it 'has a log level of error' do
      expect(actual_default_logger.level).to eq(::Logger::ERROR)
    end

    it 'has a progname of Module' do
      expect(actual_default_logger.progname).to eq(Module.to_s)
    end
  end
end

