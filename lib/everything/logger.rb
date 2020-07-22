require 'logger'

module Everything
  def self.logger
    @logger ||= default_logger
  end

  def self.logger=(value)
    @logger = value
  end

  def self.default_logger
    ::Logger.new(
      $stdout,
      level: ::Logger::ERROR,
      progname: self.class.to_s
    )
  end
end

