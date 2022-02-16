# frozen_string_literal: true

RSpec.describe Kozo::Vertex do
  subject(:vertex) { build(:vertex) }

  it "adds an edge" do
    child = build(:vertex, value: "child")

    vertex << child

    expect(vertex.edges.to_a).to eq ["child"]
  end

  it "does not add an edge twice" do
    child = build(:vertex, value: "child")

    vertex << child
    vertex << child

    expect(vertex.edges.to_a).to eq ["child"]
  end
end
