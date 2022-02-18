# frozen_string_literal: true

FactoryBot.define do
  factory :planner, class: "Kozo::Planner" do
    initialize_with { new(resources_in_state, resources_in_configuration) }

    resources_in_state { [] }
    resources_in_configuration { [] }
  end
end
