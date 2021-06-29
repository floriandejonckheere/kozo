# frozen_string_literal: true

RSpec.describe Kozo::DSL do
  subject(:dsl) { described_class.new(configuration) }

  let(:configuration) { build(:configuration) }

  describe "#backend" do
    it "raises on unknown backend type" do
      expect { dsl.backend("foo") }.to raise_error Kozo::InvalidResource
    end

    it "configures a backend" do
      dsl.backend("local") { |b| b.directory = "/tmp" }

      expect(configuration.backend).to eq build(:local_backend, directory: "/tmp")
    end
  end

  describe "#provider" do
    it "raises on unknown provider type" do
      expect { dsl.provider("foo") }.to raise_error Kozo::InvalidResource
    end

    it "configures a provider" do
      dsl.provider("null")

      expect(configuration.providers["null"]).to eq build(:null)
    end
  end

  describe "#resource" do
    it "raises on unknown resource type" do
      expect { dsl.resource("foo", "bar") }.to raise_error Kozo::InvalidResource
    end

    it "raises on unregistered provider" do
      expect { dsl.resource("null", "bar") }.to raise_error Kozo::InvalidResource
    end

    it "configures a resource" do
      dsl.provider("null")
      dsl.resource("null", "bar")

      expect(configuration.resources).to include build(:null_resource, id: nil, state_name: nil)
    end
  end
end
