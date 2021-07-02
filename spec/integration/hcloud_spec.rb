# frozen_string_literal: true

require "tmpdir"

RSpec.describe "Hetzner Cloud", if: (ENV.fetch("INTEGRATION_TEST", 0)&.to_i == 1) do
  include FakeFS::SpecHelpers

  let(:directory) { Dir.mktmpdir }

  around do |example|
    FakeFS do
      FakeFS::FileSystem.clone(Kozo.root.join("spec/support/fixtures/hcloud"))

      example.run
    end
  end

  xit "creates, updates and destroys resources in Hetzner Cloud"
end
