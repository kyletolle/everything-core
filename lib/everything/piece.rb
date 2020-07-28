require 'forwardable'

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

    def_delegators :content, :absolute_dir, :absolute_path, :body, :dir, :file_name, :path, :raw_markdown, :raw_markdown=, :title

    def metadata
      @metadata ||= Metadata.new(full_path)
    end

    def public?
      metadata['public']
    end

    def_delegators :metadata, :raw_yaml, :raw_yaml=

    def name
      @name ||= File.basename(full_path)
    end

    def save
      content.save
      metadata.save
    end
  end
end

require 'everything/piece/content'
require 'everything/piece/metadata'

