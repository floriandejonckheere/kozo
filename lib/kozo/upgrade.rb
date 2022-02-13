# frozen_string_literal: true

module Kozo
  class Upgrade
    attr_reader :state

    def initialize(state)
      @state = state
    end

    def upgrade
      raise NotImplementedError
    end
  end
end
