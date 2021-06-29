# frozen_string_literal: true

require "yaml"

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

        self.state = Kozo.container.resolve("state") unless File.exist?(path)
      end

      def data
        Kozo.logger.debug "Reading local state in #{path}"

        @data ||= YAML
          .safe_load(File.read(path))
          .deep_symbolize_keys
      rescue Errno::ENOENT
        abort "Local state at #{path} not initialized"
      rescue Psych::SyntaxError => e
        raise InvalidState, "Could not read state file: #{e.message}"
      end

      def data=(value)
        raise ArgumentError unless value.is_a? Hash

        Kozo.logger.debug "Writing local state in #{path}"

        @data = value

        File.write(path, value.deep_stringify_keys.to_yaml)
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
