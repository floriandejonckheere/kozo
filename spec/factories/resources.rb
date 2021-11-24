# frozen_string_literal: true

FactoryBot.define do
  factory :resource, class: "Kozo::Resource" do
    initialize_with { new(**attributes) }

    id { SecureRandom.hex }
    state_name { FFaker::Lorem.word.downcase }

    # Clear dirty state of object
    after(:build, &:clear_changes)
  end
end
