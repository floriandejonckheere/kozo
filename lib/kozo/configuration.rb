# frozen_string_literal: true

module Kozo
  class Configuration
    def log_level
      ENV.fetch("LOG_LEVEL", "info")
    end
  end
end
