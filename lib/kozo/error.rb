# frozen_string_literal: true

module Kozo
  class Error < StandardError; end

  class InvalidResource < Error; end

  class ExitError < Error; end

  class UsageError < Error; end

  class StateError < Error; end
end
