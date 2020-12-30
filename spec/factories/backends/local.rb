# frozen_string_literal: true

FactoryBot.define do
  factory :local_backend, parent: :backend, class: "Kozo::Backends::Local" do
    directory { Dir.mktmpdir }
  end
end
