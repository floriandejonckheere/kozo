# frozen_string_literal: true

module CoreExt
  module NilClass
    def to_b
      self
    end
  end
end

NilClass.prepend CoreExt::NilClass
