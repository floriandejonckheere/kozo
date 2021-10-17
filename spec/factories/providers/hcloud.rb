# frozen_string_literal: true

FactoryBot.define do
  factory :hcloud, parent: :provider, class: "Kozo::Providers::HCloud::Provider" do
    key { SecureRandom.uuid }
  end

  factory :hcloud_resource, parent: :resource, class: "Kozo::Providers::HCloud::Resource" do
    provider { build(:hcloud) }
  end

  factory :hcloud_ssh_key, parent: :hcloud_resource, class: "Kozo::Providers::HCloud::Resources::SSHKey" do
    name { FFaker::Lorem.word }
    public_key { "-----BEGIN PUBLIC KEY-----\ndummy\n-----END PUBLIC KEY-----" }
  end

  factory :hcloud_server, parent: :hcloud_resource, class: "Kozo::Providers::HCloud::Resources::Server" do
    name { FFaker::Lorem.word }
    image { %w(debian-9 debian-10 debian-11 ubuntu-18.04 ubuntu-20.04 fedora-34).sample }
    server_type { "c#{['p', nil].sample}x#{rand(1..5)}1" }
    location { %w(nbg fsn hsn).sample }

    user_data { {} }
    labels { {} }
  end
end
