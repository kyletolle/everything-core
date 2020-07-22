require 'logger'
require_relative 'logger/base'
require_relative 'logger/debug'
require_relative 'logger/error'
require_relative 'logger/verbose'

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

