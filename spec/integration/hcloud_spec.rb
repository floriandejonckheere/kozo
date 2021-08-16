# frozen_string_literal: true

RSpec.describe "Hetzner Cloud", integration: true, order: :defined do
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
