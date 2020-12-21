# frozen_string_literal: true

RSpec.describe Kozo::DSL do
  subject(:dsl) { described_class.new(configuration) }

  let(:configuration) { build(:configuration) }

  describe "#backend" do
    it "raises on unknown backend type" do
      expect { dsl.backend("foo") }.to raise_error SystemExit
    end

    it "configures a backend" do
      dsl.backend("local") { |b| b.directory = "/tmp" }

      expect(configuration.backend).to eq build(:local_backend, directory: "/tmp")
    end
  end

  describe "#provider" do
    it "raises on unknown provider type" do
      expect { dsl.provider("foo") }.to raise_error SystemExit
    end

    it "configures a provider" do
      dsl.provider("null")

      expect(configuration.providers).to include build(:null_provider)
    end
  end
end
