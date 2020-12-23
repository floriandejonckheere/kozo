# frozen_string_literal: true

FactoryBot.define do
  factory :configuration, class: "Kozo::Configuration" do
    directory { FFaker::Filesystem.directory }
    providers { {} }
    resources { {} }
  end
end
