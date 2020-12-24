# frozen_string_literal: true

require "json"

module Kozo
  module Backends
    class Local < Kozo::Backend
      def initialize(directory)
        super

        @directory ||= Kozo.options.directory
      end

      def initialize!
        Kozo.logger.debug "Initializing local state in #{file}"

        self.state = meta unless File.exist?(file)
      end

      def validate!
        version = state.fetch(:version)
        kozo_version = state.fetch(:kozo_version)

        unless version == Backend::VERSION
          Kozo.logger.fatal "Invalid version in state: got #{version}, expected #{Backend::VERSION}"
        end

        return if kozo_version == Kozo::VERSION

        Kozo.logger.fatal "Invalid kozo version in state: got #{kozo_version}, expected #{Kozo::VERSION}"
      end

      def state
        Kozo.logger.debug "Reading local state in #{file}"

        @state ||= JSON.parse(File.read(file), symbolize_names: true)
      rescue JSON::ParserError => e
        Kozo.logger.fatal "Could not read state file: #{e.message}"
      end

      def state=(value)
        Kozo.logger.debug "Writing local state in #{file}"

        @state = value

        File.write(file, value.to_json)
      end

      def ==(other)
        directory == other.directory
      end

      private

      def file
        @file ||= File.join(directory, "kozo.kzstate")
      end
    end
  end
end
