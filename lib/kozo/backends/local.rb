# frozen_string_literal: true

require "fileutils"
require "yaml"

module Kozo
  module Backends
    class Local < Kozo::Backend
      attr_writer :file
      attr_accessor :backups

      def initialize(configuration, directory)
        super

        @directory ||= Kozo.options.directory
      end

      def initialize!
        Kozo.logger.debug "Initializing local state in #{path}"

        return if File.exist?(path)

        # Initialize empty local state
        self.state = Kozo.container.resolve("state")
      end

      def data
        Kozo.logger.debug "Reading local state in #{path}"

        YAML
          .safe_load(File.read(path))
          .deep_symbolize_keys
      rescue Errno::ENOENT, Errno::ENOTDIR
        raise StateError, "local state at #{path} not initialized"
      rescue Psych::SyntaxError => e
        raise StateError, "could not read state file: #{e.message}"
      end

      def data=(value)
        Kozo.logger.debug "Writing local state in #{path}"

        @data = value

        # Write backup state file
        FileUtils.mv(path, "#{path}.#{DateTime.current.to_i}.kzbackup") if backups

        # Write local state file
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
