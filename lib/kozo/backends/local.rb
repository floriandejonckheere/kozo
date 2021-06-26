# frozen_string_literal: true

require "json"

module Kozo
  module Backends
    class Local < Kozo::Backend
      attr_writer :file

      def initialize(configuration, directory)
        super

        @directory ||= Kozo.options.directory
      end

      def initialize!
        Kozo.logger.debug "Initializing local state in #{path}"

        self.data = State.new.to_h unless File.exist?(path)
      end

      def data
        Kozo.logger.debug "Reading local state in #{path}"

        @data ||= JSON
          .parse(File.read(path), symbolize_names: true)
      rescue JSON::ParserError => e
        raise InvalidState, "Could not read state file: #{e.message}"
      end

      def data=(value)
        raise ArgumentError unless value.is_a? Hash

        Kozo.logger.debug "Writing local state in #{path}"

        @data = value

        File.write(path, value.to_json)
      end

      def file
        @file ||= "kozo.kzstate"
      end

      def path
        @path ||= File.join(directory, file)
      end
    end
  end
end
