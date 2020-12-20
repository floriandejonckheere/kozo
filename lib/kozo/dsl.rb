# frozen_string_literal: true

module Kozo
  class DSL
    def kozo(&_block)
      yield
    end

    def backend(type, &_block)
      Kozo.logger.debug "Initializing backend #{type}"
    end

    def provider(type, &_block)
      Kozo.logger.debug "Initializing provider #{type}"
    end

    def resource(type, name, &_block)
      Kozo.logger.debug "Initializing resource #{type} #{name}"
    end
  end
end
