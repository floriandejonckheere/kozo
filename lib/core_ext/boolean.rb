# frozen_string_literal: true

module CoreExt
  module Boolean
    def to_b
      self
    end
  end
end

TrueClass.prepend CoreExt::Boolean
FalseClass.prepend CoreExt::Boolean
