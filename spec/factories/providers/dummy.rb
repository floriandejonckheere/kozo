# frozen_string_literal: true

FactoryBot.define do
  factory :dummy, parent: :provider, class: "Kozo::Providers::Dummy::Provider"

  factory :dummy_resource, parent: :resource, class: "Kozo::Providers::Dummy::Resources::Dummy" do
    provider { build(:dummy) }

    name { "dummy" }
    description { "Dummy resource" }
  end
end
