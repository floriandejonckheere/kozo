# frozen_string_literal: true

RSpec.describe Kozo::Configuration do
  subject(:configuration) { build(:configuration) }

  it "defaults to local backend" do
    expect(configuration.backend).to be_a Kozo::Backends::Local
  end
end
