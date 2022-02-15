# frozen_string_literal: true

FactoryBot.define do
  factory :resource_set, class: "Kozo::ResourceSet" do
    initialize_with { new(resources) }

    resources { build_list(:resource, 3) }
  end
end
