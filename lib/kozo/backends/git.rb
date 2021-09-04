# frozen_string_literal: true

require "git"

module Kozo
  module Backends
    class Git < Local
      attr_writer :repository
      attr_accessor :remote

      def initialize!
        Kozo.logger.debug "Initializing local state in #{repository_path}"

        return if Dir.exist?(repository_path)

        # Initialize git repository
        @git = ::Git.init(repository_path)
        git.add_remote("origin", remote) if remote

        super
      end

      def data=(value)
        super

        git.add(file)
        git.commit("Update Kozo resource state")
        git.push(git.remote("origin")) if remote
      end

      def repository
        @repository ||= "kozo.git"
      end

      private

      def repository_path
        @repository_path ||= File.join(directory, repository)
      end

      def path
        @path ||= File.join(directory, repository, file)
      end

      def git
        @git ||= Git.open(path)
      end
    end
  end
end
