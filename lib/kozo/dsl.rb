# frozen_string_literal: true

module Kozo
  class DSL
    attr_reader :workspace

    def initialize(workspace)
      @workspace = workspace
    end

    def kozo(&_block)
      yield
    end

    def backend(type, &_block)
      Kozo.logger.debug "Initializing backend #{type}"

      klass = "Kozo::Backends::#{type.camelize}".safe_constantize

      Kozo.logger.fatal "Unknown backend: #{type}" unless klass

      workspace.backend = yield klass.new
    end

    def provider(type, &_block)
      Kozo.logger.debug "Initializing provider #{type}"
    end

    def resource(type, name, &_block)
      Kozo.logger.debug "Initializing resource #{type} #{name}"
    end
  end
end
