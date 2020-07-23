require 'dotenv'
Dotenv.load

require 'fastenv'
require 'everything/version'
require 'everything/logger'
require 'everything/piece'

module Everything
  def self.path
    Fastenv.everything_path
  end
end

