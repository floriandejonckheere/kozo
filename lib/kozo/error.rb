# frozen_string_literal: true

module Kozo
  # Base class
  class Error < StandardError; end

  # Raised when usage is printed
  class ExitError < Error; end

  # Raised when CLI arguments are invalid
  class UsageError < Error; end

  # Raised when a resource definition was invalid
  class InvalidResource < Error; end

  # Raised when a resource cannot match constraints (uniqueness, etc.)
  class ResourceError < Error; end

  # Raised when state invalid or resource not found in state
  class StateError < Error; end

  # Raised when performing an operation on a resource that was not persisted yet
  class NotPersisted < Error; end
end
