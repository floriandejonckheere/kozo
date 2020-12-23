# frozen_string_literal: true

require "json"

module Kozo
  module Backends
    class Local < Base
      def state
        Kozo.logger.debug "reading local state in #{file}"

        File.write(file, {}.to_json) unless File.exist?(file)

        JSON.parse(File.read(file), symbolize_names: true)
      rescue JSON::ParserError => e
        Kozo.logger.fatal "could not read state file: #{e.message}"
      end

      def state=(value)
        Kozo.logger.debug "writing local state in #{file}"
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
