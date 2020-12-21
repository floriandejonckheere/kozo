# frozen_string_literal: true

FactoryBot.define do
  factory :null_provider, class: "Kozo::Providers::Null::Provider"

  factory :hcloud_provider, class: "Kozo::Providers::HCloud" do
    key { SecureRandom.uuid }
  end
end
