# frozen_string_literal: true

FactoryBot.define do
  factory :resource, class: "Kozo::Resource" do
    state_name { FFaker::Lorem.word.downcase }

    factory :null_resource, class: "Kozo::Providers::Null::Resources::Null"

    factory :hcloud_ssh_key, class: "Kozo::Providers::HCloud::Resources::SSHKey" do
      name { FFaker::Lorem.word }
      public_key { "-----BEGIN PUBLIC KEY-----\ndummy\n-----END PUBLIC KEY-----" }
    end
  end
end
