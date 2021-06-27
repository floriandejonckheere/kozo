# frozen_string_literal: true

module Kozo
  class Command
    class_attribute :description

    attr_reader :args

    def initialize(args = nil)
      @args = args
    end

    def start
      raise NotImplementedError
    end

    protected

    def environment
      @environment ||= Kozo.container.resolve("environment", Kozo.options.directory)
    end

    delegate :configuration, :state, to: :environment
  end
end
