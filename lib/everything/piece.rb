require 'forwardable'

module Everything
  class Piece
    extend Forwardable

    attr_reader :full_path

    # TODO: Add the following methods:
    #   - dir (Relative to Everything.path)
    #   - path (Relative to Everything.path)
    #   - absolute_dir
    #   - absolute_path

    def initialize(full_path)
      @full_path = full_path
    end

    def content
      @content ||= Content.new(full_path)
    end

    def dir
      @dir ||= calculated_dir
    end

    def_delegators :content, :body, :raw_markdown, :raw_markdown=, :title

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

    def path
      @path ||= File.join(dir, content.file_name)
    end

    def save
      content.save
      metadata.save
    end

  private

    def calculated_dir
      everything_pathname = Pathname.new(Everything.path)
      full_pathname = Pathname.new(full_path)
      relative_pathname = full_pathname.relative_path_from(everything_pathname)
      relative_pathname.to_s
    end
  end
end

require 'everything/piece/content'
require 'everything/piece/metadata'

