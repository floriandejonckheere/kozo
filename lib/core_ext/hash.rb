# frozen_string_literal: true

module CoreExt
  module Hash
    def as_s
      return "{}" if empty?

      map { |k, v| "  #{k} = #{v}" }
        .intersperse(",")
        .prepend("{")
        .append("}")
        .join("\n")
    end
  end
end

Hash.prepend CoreExt::Hash
