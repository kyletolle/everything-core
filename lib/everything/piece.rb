module Everything
  class Piece
    extend Forwardable

    attr_reader :full_path

    def initialize(full_path)
      @full_path = full_path
    end

    def content
      @content ||= Content.new(full_path)
    end

    def_delegators :content, :body, :raw_markdown, :title

    def metadata
      @metadata ||= Metadata.new(full_path)
    end

    def public?
      metadata['public']
    end

    def name
      File.basename(full_path)
    end
  end
end

require 'everything/piece/content'
require 'everything/piece/metadata'

