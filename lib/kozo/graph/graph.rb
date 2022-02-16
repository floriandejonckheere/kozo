# frozen_string_literal: true

module Kozo
  class Graph
    attr_accessor :vertices

    def initialize
      @vertices = Hash.new { |hash, key| hash[key] = Vertex.new(key) }
    end

    def <<(vertex)
      vertices[vertex.value] = vertex
    end

    delegate :[],
             :delete,
             to: :vertices

    def inspect
      "#<Kozo::Graph vertices=#{vertices.each_value.map(&:inspect)}>"
    end
  end
end
