# frozen_string_literal: true

require "fileutils"
require "yaml"

module Kozo
  module Backends
    class Local < Kozo::Backend
      attr_writer :file
      attr_accessor :backups
      attr_reader :fingerprint

      def initialize(configuration, directory)
        super

        @directory ||= Kozo.options.directory
      end

      def initialize!
        Kozo.logger.debug "Initializing local state in #{path}"

        return if File.exist?(path)

        # Initialize empty local state
        self.state = State.new
      end

      def data
        Kozo.logger.debug "Reading local state in #{path}"

        YAML
          .safe_load(File.read(path), permitted_classes: [Time, Date])
          .deep_symbolize_keys
      rescue Errno::ENOENT, Errno::ENOTDIR
        raise StateError, "local state at #{path} not initialized"
      rescue Psych::SyntaxError => e
        raise StateError, "could not read state file: #{e.message}"
      end

      def data=(value)
        Kozo.logger.debug "Writing local state in #{path}"

        return if @data.hash == value.hash

        @data = value

        return if Kozo.options.dry_run?

        # Write backup state file
        FileUtils.mv(path, "#{path}.#{DateTime.current.to_i}.kzbackup") if backups && File.exist?(path)

        # Write local state to temporary file
        File.write("#{path}.tmp", value.deep_stringify_keys.to_yaml)

        # Move temporary file to local state file
        FileUtils.mv("#{path}.tmp", path)
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
