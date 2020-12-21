# frozen_string_literal: true

RSpec.describe Kozo::Container do
  subject(:container) { described_class.new }

  let(:dependency) { ->(arg) { arg.reverse } }

  describe "#register" do
    it "raises when dependency already registered" do
      container.register(:foo) { dependency }

      expect { container.register(:foo) { dependency } }.to raise_error Kozo::Container::DependencyAlreadyRegistered
    end

    it "does not raise when forcing dependency registration" do
      container.register(:foo) { dependency }

      expect { container.register("foo", force: true) { dependency } }.not_to raise_error
    end

    it "registers a dependency" do
      container.register(:foo) { dependency }
    end
  end

  describe "#resolve" do
    it "raises when dependency does not exist" do
      expect { container.resolve(:foo) }.to raise_error Kozo::Container::DependencyNotRegistered
    end

    it "does not raise when quietly resolving dependency" do
      expect { container.resolve(:foo, quiet: true) }.not_to raise_error
    end

    it "resolves a dependency" do
      container.register(:foo) { dependency }

      expect(container.resolve(:foo).call("bar")).to eq "rab"
    end
  end
end
