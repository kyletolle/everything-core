require 'fileutils'
require 'yaml'

module Everything
  class Piece
    class Metadata
      extend Forwardable

      # TODO: Need to add some ways in here to save the metadata file once it's
      # been edited.
      # TODO: Also add a #to_s or #inspect methods to render the raw_yaml
      # TODO: Also add a #[]= here that delegates to raw_yaml as well.

      def initialize(piece_path)
        @piece_path = piece_path
      end

      def absolute_dir
        @absolute_dir ||= File.join(Everything.path, dir)
      end

      def dir
        @dir ||= calculated_dir
      end

      def file_path
        @file_path ||= File.join(piece_path, file_name)
      end

      def path
        @path ||= File.join(dir, file_name)
      end

      def raw_yaml
        @raw_yaml ||= YAML.load_file(file_path)
      end

      def raw_yaml=(value)
        @raw_yaml = value
      end

      def save
        FileUtils.mkdir_p(piece_path)

        File.write(file_path, @raw_yaml)
      end

      def_delegators :raw_yaml, :[]

    private
      attr_reader :piece_path

      def file_name
        'index.yaml'
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
