# frozen_string_literal: true

FactoryBot.define do
  factory :configuration, class: "Kozo::Configuration" do
    initialize_with { new(directory) }

    directory { FFaker::Filesystem.directory }
    providers { {} }
    resources { [] }
  end
end
