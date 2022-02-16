# frozen_string_literal: true

require "tsort"

module Kozo
  class Graph
    include TSort

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

    def tsort_each_node(&block)
      vertices.keys.each(&block)
    end

    def tsort_each_child(vertex, &block)
      vertices[vertex].edges.each(&block)
    end

    def inspect
      "#<Kozo::Graph vertices=#{vertices.each_value.map(&:inspect)}>"
    end
  end
end
