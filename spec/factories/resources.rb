# frozen_string_literal: true

FactoryBot.define do
  factory :resource, class: "Kozo::Resource" do
    id { SecureRandom.hex }
    state_name { FFaker::Lorem.word.downcase }

    # Persist changes after build, because FactoryBot uses accessors to set attributes
    after(:build, &:changes_applied)
  end
end
