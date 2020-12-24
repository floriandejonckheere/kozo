# frozen_string_literal: true

FactoryBot.define do
  factory :null_provider, class: "Kozo::Providers::Null::Provider"

  factory :hcloud, class: "Kozo::Providers::HCloud::Provider" do
    key { SecureRandom.uuid }
  end
end
