# frozen_string_literal: true

FactoryBot.define do
  factory :graph, class: "Kozo::Graph"

  factory :vertex, class: "Kozo::Vertex" do
    initialize_with { new(value) }

    value { "vertex" }
  end
end
