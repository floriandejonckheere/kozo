# frozen_string_literal: true

module Kozo
  class Environment < String
    def initialize
      super(ENV.fetch("KOZO_ENV", "development"))

      return if %w(development test production).include?(self)

      raise InvalidEnvironment, "Unknown environment: #{self}"
    end

    def development?
      self == "development"
    end

    def test?
      self == "test"
    end

    def production?
      self == "production"
    end

    class InvalidEnvironment < StandardError; end
  end
end
