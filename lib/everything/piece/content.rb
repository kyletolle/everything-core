require 'fileutils'

module Everything
  class Piece
    class Content
      def initialize(piece_path)
        @piece_path = piece_path
      end

      def absolute_dir
        @absolute_dir ||= Everything.path.join(dir)
      end

      def absolute_path
        @absolute_path ||= absolute_dir.join(file_name)
      end

      def dir
        @dir ||= calculated_dir
      end

      def file_name
        'index.md'
      end

      def file_path
        # TODO: Could try a deprecation approach like http://seejohncode.com/2012/01/09/deprecating-methods-in-ruby/
        deprecation_message = "Piece Content's #file_path is deprecated and will be removed soon. Use #absolute_path instead."
        warn deprecation_message
        @file_path ||= File.join(piece_path, file_name)
      end

      def title
        partitioned_text.first.sub('# ', '')
      end

      def body
        partitioned_text.last
      end

      def path
        @path ||= dir.join(file_name)
      end

      def raw_markdown
        @raw_markdown ||= absolute_path.read
      end

      def raw_markdown=(value)
        @raw_markdown = value
      end

      def save
        FileUtils.mkdir_p(piece_path)

        absolute_path.write(@raw_markdown)
      end

    private
      attr_reader :piece_path

      def partitioned_text
        @partitioned_text ||= raw_markdown.partition("\n\n")
      end

      def calculated_dir
        full_pathname = Pathname.new(piece_path)
        _relative_pathname = full_pathname.relative_path_from(Everything.path)
      end
    end
  end
end

