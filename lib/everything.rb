require 'dotenv'
Dotenv.load

require 'pathname'
require 'fastenv'
require 'everything/version'
require 'everything/logger'
require 'everything/piece'

module Everything
  def self.path
    Pathname.new(Fastenv.everything_path)
  end
end

