require 'fileutils'

module Everything
  class Piece
    class Content
      def initialize(piece_path)
        @piece_path = piece_path
      end

      def absolute_dir
        @absolute_dir ||= File.join(Everything.path, dir)
      end

      def absolute_path
        @absolute_path ||= File.join(absolute_dir, file_name)
      end

      def dir
        @dir ||= calculated_dir
      end

      def file_name
        'index.md'
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

      def path
        @path ||= File.join(dir, file_name)
      end

      def raw_markdown
        @raw_markdown ||= File.read(file_path)
      end

      def raw_markdown=(value)
        @raw_markdown = value
      end

      def save
        FileUtils.mkdir_p(piece_path)

        File.write(file_path, @raw_markdown)
      end

    private
      attr_reader :piece_path

      def partitioned_text
        @partitioned_text ||= raw_markdown.partition("\n\n")
      end

      def calculated_dir
        everything_pathname = Pathname.new(Everything.path)
        full_pathname = Pathname.new(piece_path)
        relative_pathname = full_pathname.relative_path_from(everything_pathname)
        relative_pathname.to_s
      end
    end
  end
end

