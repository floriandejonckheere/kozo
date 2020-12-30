# frozen_string_literal: true

FactoryBot.define do
  factory :null, parent: :provider, class: "Kozo::Providers::Null::Provider"

  factory :null_resource, parent: :resource, class: "Kozo::Providers::Null::Resources::Null" do
    provider { build(:null) }
  end
end
