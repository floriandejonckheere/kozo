# frozen_string_literal: true

RSpec.describe Kozo::Associations do
  subject(:object) { object_class.new }

  let(:object_class) do
    Class.new do
      include Kozo::Associations

      association :single
      association :multiple, multiple: true
    end
  end

  describe ".association_names" do
    it "returns the names of the associations" do
      expect(object_class.association_names).to match_array [:single, :multiple]
    end
  end

  describe ".association_types" do
    it "returns the types of the associations" do
      expect(object_class.association_types).to include single: { multiple: false }, multiple: { multiple: true }
    end
  end

  describe "#associations" do
    it "returns the associations" do
      object.single = "one"
      object.multiple = ["two", "three"]

      expect(object.associations).to include single: "one", multiple: ["two", "three"]
    end
  end

  describe "#single" do
    it "returns nil when uninitialized" do
      expect(object.single).to eq nil
    end

    it "returns the value" do
      object.single = "one"

      expect(object.single).to eq "one"
    end
  end

  describe "#multiple" do
    it "returns empty when uninitialized" do
      expect(object.multiple).to be_empty
    end

    it "returns the value" do
      object.multiple = ["two", "three"]

      expect(object.multiple).to match_array ["two", "three"]
    end

    it "appends to the array" do
      object.multiple << "four"

      expect(object.multiple).to match_array ["four"]
    end
  end
end
