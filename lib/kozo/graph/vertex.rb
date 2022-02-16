# frozen_string_literal: true

module Kozo
  class Vertex
    attr_accessor :value, :edges

    def initialize(value, edges = Set.new)
      @value = value
      @edges = edges
    end

    def <<(vertex)
      edges << vertex.value

      vertex
    end

    def inspect
      "#<#{self.class.name} value=#{value} edges=[#{edges.join(', ')}]>"
    end
  end
end
