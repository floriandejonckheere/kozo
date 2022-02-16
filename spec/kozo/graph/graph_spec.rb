# frozen_string_literal: true

RSpec.describe Kozo::Graph do
  subject(:graph) { build(:graph) }

  describe "#[]" do
    it "creates a vertex" do
      vertex = graph[:address]

      expect(vertex).to be_kind_of Kozo::Vertex
      expect(vertex.value).to eq :address
      expect(vertex.edges).to be_empty
    end
  end

  describe "#<<" do
    it "adds a vertex" do
      vertex = build(:vertex, value: "vertex")

      graph << vertex

      expect(graph.vertices).not_to be_empty
    end
  end

  describe "#delete" do
    it "removes a vertex" do
      vertex = graph[:address]

      graph.delete(vertex.value)

      expect(graph.vertices).to be_empty
    end
  end

  describe "#tsort" do
    it "topologically sorts the graph" do
      a = graph[:a]
      b = graph[:b]
      c = graph[:c]
      d = graph[:d]
      graph[:e]

      # A requires B
      a << b

      # B requires D
      b << d

      # C also requires D
      c << d

      expect(graph.tsort).to eq [:d, :b, :a, :c, :e]
    end
  end
end
