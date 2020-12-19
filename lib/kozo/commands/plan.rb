# frozen_string_literal: true

module Kozo
  class Plan < Base
    def start
      raise NotImplementedError
    end
  end
end
