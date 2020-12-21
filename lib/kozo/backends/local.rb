# frozen_string_literal: true

require "json"

module Kozo
  module Backends
    class Local < Base
      def state
        Kozo.logger.debug "Reading local state in #{file}"

        File.write(file, {}.to_json) unless File.exist?(file)

        JSON.parse(File.read(file), symbolize_names: true)
      rescue JSON::ParserError => e
        Kozo.logger.fatal "Could not read state file: #{e.message}"
      end

      def state=(value)
        Kozo.logger.debug "Writing local state in #{file}"
        File.write(file, value.to_json)
      end

      private

      def file
        @file ||= File.join(directory, "kozo.kzstate")
      end
    end
  end
end
