# frozen_string_literal: true

FactoryBot.define do
  factory :command, class: "Kozo::Command" do
    initialize_with { new(nil, *args) }

    transient do
      args { [] }
    end
  end

  factory :state_command, parent: :command, class: "Kozo::Commands::State" do
    factory :state_list_command, class: "Kozo::Commands::State::List"
    factory :state_show_command, class: "Kozo::Commands::State::Show"
    factory :state_delete_command, class: "Kozo::Commands::State::Delete"
    factory :state_upgrade_command, class: "Kozo::Commands::State::Upgrade"
  end

  factory :import_command, parent: :command, class: "Kozo::Commands::Import"

  factory :plan_command, parent: :command, class: "Kozo::Commands::Plan"

  factory :version_command, parent: :command, class: "Kozo::Commands::Version"
end
