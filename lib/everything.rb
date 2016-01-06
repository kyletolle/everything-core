require 'dotenv'
Dotenv.load

require 'fastenv'
require 'everything/version'
require 'everything/piece'

class Everything
  def self.path
    Fastenv.everything_path
  end
end

