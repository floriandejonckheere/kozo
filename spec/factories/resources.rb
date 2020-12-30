# frozen_string_literal: true

FactoryBot.define do
  factory :resource, class: "Kozo::Resource" do
    state_name { FFaker::Lorem.word.downcase }
  end
end
