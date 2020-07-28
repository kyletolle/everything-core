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
        @absolute_dir ||= Everything.path.join(dir)
      end

      def absolute_path
        @absolute_path ||= absolute_dir.join(file_name)
      end

      def dir
        @dir ||= calculated_dir
      end

      def file_path
        # TODO: Could try a deprecation approach like http://seejohncode.com/2012/01/09/deprecating-methods-in-ruby/
        deprecation_message = "Piece Metadata's #file_path is deprecated and will be removed soon. Use #absolute_path instead."
        warn deprecation_message
        @file_path ||= File.join(piece_path, file_name)
      end

      def path
        @path ||= dir.join(file_name)
      end

      def raw_yaml
        @raw_yaml ||= YAML.load_file(absolute_path)
      end

      def raw_yaml=(value)
        @raw_yaml = value
      end

      def save
        FileUtils.mkdir_p(piece_path)

        absolute_path.write(@raw_yaml)
      end

      def_delegators :raw_yaml, :[]

    private
      attr_reader :piece_path

      def file_name
        'index.yaml'
      end

      def calculated_dir
        full_pathname = Pathname.new(piece_path)
        _relative_pathname = full_pathname.relative_path_from(Everything.path)
      end
    end
  end
end
