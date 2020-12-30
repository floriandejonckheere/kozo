# frozen_string_literal: true

require "json"

module Kozo
  module Backends
    class Local < Kozo::Backend
      def initialize(configuration, directory)
        super

        @directory ||= Kozo.options.directory
      end

      def initialize!
        Kozo.logger.debug "Initializing local state in #{file}"

        self.data = State.new.to_h unless File.exist?(file)
      end

      def data
        Kozo.logger.debug "Reading local state in #{file}"

        @data ||= JSON
          .parse(File.read(file), symbolize_names: true)
      rescue JSON::ParserError => e
        raise InvalidState, "Could not read state file: #{e.message}"
      end

      def data=(value)
        raise ArgumentError unless value.is_a? Hash

        Kozo.logger.debug "Writing local state in #{file}"

        @data = value

        File.write(file, value.to_json)
      end

      private

      def file
        @file ||= File.join(directory, "kozo.kzstate")
      end
    end
  end
end
