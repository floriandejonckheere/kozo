# frozen_string_literal: true

module Kozo
  module Commands
    class State
      class Upgrade < State
        self.description = "Upgrade the state file to the latest version"

        def initialize(configuration, *_args)
          @configuration = configuration
        end

        def start
          return Kozo.logger.info "State file already up to date." if state.compatible?

          ((state.version + 1)..Kozo::State::VERSION).each do |version|
            file = Dir[Kozo.root.join("lib/kozo/upgrade/#{version}_*")].first

            raise NotImplementedError, "upgrade file to version #{version} not found" unless file

            Kozo.logger.info "Upgrading state file to version #{version}"

            klass = File
              .basename(file, ".rb")
              .delete_prefix("#{version}_")
              .prepend("kozo/upgrade/")
              .camelize
              .constantize

            # Write state
            configuration.backend.state = klass
              .new(state)
              .upgrade
          end
        end

        def state
          @state ||= configuration
            .backend
            .state(verify: false)
        end
      end
    end
  end
end
