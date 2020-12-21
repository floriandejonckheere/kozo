# frozen_string_literal: true

RSpec.describe Kozo::DSL do
  subject(:dsl) { described_class.new(configuration) }

  let(:configuration) { build(:configuration) }
  let(:backend) { build(:local_backend, directory: "/tmp") }
  let(:provider) { build(:hcloud_provider, key: "my_key") }

  describe "#backend" do
    it "raises on unknown backend type" do
      expect { dsl.backend("foo") }.to raise_error SystemExit
    end

    it "configures a backend" do
      dsl.backend("local") { |b| b.directory = "/tmp" }

      expect(configuration.backend).to eq backend
    end
  end

  describe "#provider" do
    it "raises on unknown provider type" do
      expect { dsl.provider("foo") }.to raise_error SystemExit
    end

    it "configures a provider" do
      dsl.provider("hcloud") { |p| p.key = "my_key" }

      expect(configuration.providers).to include provider
    end
  end
end