# frozen_string_literal: true

require "json"

module Kozo
  module Backends
    class Local < Base
      def state
        Kozo.logger.debug "Reading local state in #{file}"
        JSON.parse(File.read(file), symbolize_names: true)
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
