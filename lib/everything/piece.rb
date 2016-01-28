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
  end
end

require 'everything/piece/content'

