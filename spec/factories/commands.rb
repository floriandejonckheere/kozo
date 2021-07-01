# frozen_string_literal: true

FactoryBot.define do
  factory :command, class: "Kozo::Command" do
    initialize_with { new(args) }

    transient do
      args { [] }
    end
  end

  factory :state_command, parent: :command, class: "Kozo::Commands::State" do
    factory :state_list_command, class: "Kozo::Commands::State::List"
    factory :state_show_command, class: "Kozo::Commands::State::Show"
  end

  factory :plan_command, parent: :command, class: "Kozo::Commands::Plan"
end
