# frozen_string_literal: true

# require "fakefs/spec_helpers"
require "fileutils"

RSpec.describe "Hetzner Cloud", integration: true, order: :defined do
  # include FakeFS::SpecHelpers

  let(:directory) { Dir.mktmpdir }

  before { FileUtils.cp_r Kozo.root.join("spec/fixtures/hcloud/."), directory }

  around { |example| Dir.chdir(directory) { example.run } }

  after { FileUtils.rm_rf directory }

  # around do |example|
  #   FakeFS do
  #     FakeFS::FileSystem.clone(Kozo.root.join("spec/fixtures/hcloud").to_s)
  #
  #     example.run
  #   end
  # end

  it "creates, updates and destroys resources in Hetzner Cloud" do
    require "byebug"
    byebug
  end
end
