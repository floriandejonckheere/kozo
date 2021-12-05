# frozen_string_literal: true

module CoreExt
  module Float
    def as_s
      to_s
    end
  end
end

Float.prepend CoreExt::Float
