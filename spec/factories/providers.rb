# frozen_string_literal: true

FactoryBot.define do
  factory :hcloud_provider, class: "Kozo::Providers::HCloud" do
    key { SecureRandom.uuid }
  end
end
