# frozen_string_literal: true

module CoreExt
  module Integer
    def as_s
      to_s
    end
  end
end

Integer.prepend CoreExt::Integer
