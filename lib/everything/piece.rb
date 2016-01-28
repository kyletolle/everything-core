module Everything
  class Piece
    attr_reader :full_path

    def initialize(full_path)
      @full_path = full_path
    end

    def content
      @content ||= partitioned_content.last
    end

    def title
      @title ||= partitioned_content.first.sub('# ', '')
    end

    def raw_markdown
      @raw_markdown ||= File.read(content_path)
    end

  private
    def content_path
      @content_path ||= File.join(@full_path, 'index.md')
    end

    def partitioned_content
      @partitioned_content ||= raw_markdown.partition("\n\n")
    end
  end
end

require 'everything/piece/content'

