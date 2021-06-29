# frozen_string_literal: true

require "tmpdir"

RSpec.describe Kozo::Configuration do
  subject(:configuration) { build(:configuration, directory: Dir.pwd) }

  it "defaults to local backend" do
    expect(configuration.backend).to be_a Kozo::Backends::Local
  end
end
