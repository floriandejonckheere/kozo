# frozen_string_literal: true

FactoryBot.define do
  factory :provider, class: "Kozo::Provider" do
    after(:build, &:initialize!)
  end
end
