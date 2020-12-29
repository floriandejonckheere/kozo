# frozen_string_literal: true

FactoryBot.define do
  factory :local_backend, class: "Kozo::Backends::Local" do
    initialize_with { Kozo::Backends::Local.new(configuration, directory) }

    configuration { build(:configuration) }
    directory { Dir.mktmpdir }
  end
end
