# frozen_string_literal: true

module Kozo
  class Error < StandardError; end

  class ExitError < StandardError; end

  class UsageError < Error; end
end
