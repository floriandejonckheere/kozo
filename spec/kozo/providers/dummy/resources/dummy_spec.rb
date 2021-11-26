# frozen_string_literal: true

RSpec.describe Kozo::Providers::Dummy::Resources::Dummy do
  subject(:resource) { build(:dummy_resource) }

  it { is_expected.to have_arguments :name, :description }
  it { is_expected.to have_attribute :name, :description }
end
