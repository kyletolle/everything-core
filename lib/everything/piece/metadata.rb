require 'yaml'

module Everything
  class Piece
    class Metadata
      extend Forwardable

      def initialize(piece_path)
        @piece_path = piece_path
      end

      def file_path
        @file_path ||= File.join(piece_path, file_name)
      end

      def raw_yaml
        @raw_yaml ||= YAML.load_file(file_path)
      end

      def raw_yaml=(value)
        @raw_yaml = value
      end

      def_delegators :raw_yaml, :[]

    private
      attr_reader :piece_path

      def file_name
        'index.yaml'
      end
    end
  end
end
