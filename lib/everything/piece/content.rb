module Everything
  class Piece
    class Content
      def initialize(piece_path)
        @piece_path = piece_path
      end

      def file_path
        @file_path ||= File.join(piece_path, file_name)
      end

      def title
        partitioned_text.first.sub('# ', '')
      end

      def body
        partitioned_text.last
      end

      def raw_markdown
        @raw_markdown ||= File.read(file_path)
      end

      def raw_markdown=(value)
        @raw_markdown = value
      end

    private
      attr_reader :piece_path

      def file_name
        'index.md'
      end

      def partitioned_text
        @partitioned_text ||= raw_markdown.partition("\n\n")
      end
    end
  end
end
