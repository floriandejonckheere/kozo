# frozen_string_literal: true

FactoryBot.define do
  factory :state, class: Hash do
    initialize_with { attributes }

    providers { [] }
    resources { [] }
  end
end
