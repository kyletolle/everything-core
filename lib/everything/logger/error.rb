module Everything
  class Logger
    class Error < Everything::Logger::Base
      def initialize(logdev, progname: nil)
        super
        self.level = ::Logger::ERROR
      end
    end
  end
end

