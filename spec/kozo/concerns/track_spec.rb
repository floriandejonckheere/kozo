# frozen_string_literal: true

RSpec.describe Kozo::Track do
  subject(:object) { object_class.new }

  let(:object_class) do
    Class.new do
      include Kozo::Track
      include Kozo::Attributes
      include Kozo::Arguments

      argument :property
      attribute :property
    end
  end

  describe "#changed?" do
    it "is not changed when initialized" do
      expect(object).not_to be_changed
    end

    it "is not changed when it is the same value" do
      object.property = nil

      expect(object).not_to be_changed
    end

    it "is changed when changing a property" do
      object.property = "property"

      expect(object).to be_changed
    end
  end

  describe "#clear_changes" do
    it "clears the changes" do
      object.property = "property"

      expect(object.changes).not_to be_empty
      object.clear_changes
      expect(object.changes).to be_empty
    end
  end

  describe "#restore_changes" do
    it "restores the changes" do
      object.property = "one"
      object.clear_changes

      object.property = "two"

      expect(object.property).to eq "two"
      object.restore_changes
      expect(object.property).to eq "one"
    end
  end

  describe "#*_change" do
    it "returns the change" do
      object.property = "property"

      expect(object.property_change).to eq [nil, "property"]
    end
  end

  describe "#*_changed?" do
    it "returns true if it changed" do
      object.property = "property"

      expect(object).to be_property_changed
    end

    it "returns false if it did not change" do
      expect(object).not_to be_property_changed
    end
  end

  describe "#*_was" do
    it "returns the previous value" do
      object.property = "property"

      expect(object.property_was).to eq nil
    end
  end
end
