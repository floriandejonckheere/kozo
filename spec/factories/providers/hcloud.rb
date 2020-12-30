# frozen_string_literal: true

FactoryBot.define do
  factory :hcloud, parent: :provider, class: "Kozo::Providers::HCloud::Provider" do
    key { SecureRandom.uuid }
  end

  factory :hcloud_resource, parent: :resource, class: "Kozo::Providers::HCloud::Resource" do
    provider { build(:hcloud) }

    factory :hcloud_ssh_key, class: "Kozo::Providers::HCloud::Resources::SSHKey" do
      name { FFaker::Lorem.word }
      public_key { "-----BEGIN PUBLIC KEY-----\ndummy\n-----END PUBLIC KEY-----" }
    end
  end
end
