# frozen_string_literal: true

module CoreExt
  module Enumerable
    def intersperse(value)
      flat_map { |h| [h, value] }.tap(&:pop)
    end
  end
end

Enumerable.prepend CoreExt::Enumerable
