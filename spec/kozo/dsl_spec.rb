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
      dsl.provider("dummy")

      expect(configuration.providers["dummy"]).to eq build(:dummy)
    end
  end

  describe "#resource" do
    it "raises on unknown resource type" do
      expect { dsl.resource("foo", "bar") }.to raise_error Kozo::InvalidResource
    end

    it "raises on unregistered provider" do
      expect { dsl.resource("dummy", "bar") }.to raise_error Kozo::InvalidResource
    end

    it "raises on resource already defined" do
      dsl.provider("dummy")
      dsl.resource("dummy", "bar")

      expect { dsl.resource("dummy", "bar") }.to raise_error Kozo::InvalidResource
      expect { dsl.resource("dummy", "baz") }.not_to raise_error
    end

    it "configures a resource" do
      dsl.provider("dummy")
      dsl.resource("dummy", "bar")

      expect(configuration.resources).to include build(:dummy_resource, id: nil, state_name: "bar")
    end
  end
end
