module Everything
  class Logger
    class Verbose < Everything::Logger::Base
      def initialize(logdev, progname: nil)
        super
        self.level = ::Logger::INFO
      end
    end
  end
end

