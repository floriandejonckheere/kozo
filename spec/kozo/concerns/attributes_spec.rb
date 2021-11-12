# frozen_string_literal: true

RSpec.describe Kozo::Attributes do
  subject(:object) { object_class.new }

  let(:object_class) do
    Class.new do
      include Kozo::Attributes

      attribute :single
      attribute :multiple, multiple: true

      attribute :type, type: :integer
      attribute :default, default: "a_default"
    end
  end

  describe ".attribute_names" do
    it "returns the names of the attributes" do
      expect(object_class.attribute_names).to match_array [:single, :multiple, :type, :default]
    end
  end

  describe ".attribute_types" do
    it "returns the types of the attributes" do
      expect(object_class.attribute_types).to include single: include(multiple: false), multiple: include(multiple: true)
    end
  end

  describe "#attributes" do
    it "returns the attributes" do
      object.send(:single=, "one")
      object.send(:multiple=, ["two", "three"])

      expect(object.attributes).to include single: "one", multiple: ["two", "three"]
    end
  end

  describe "#single" do
    it "raises because the method is private" do
      expect { object.single = "one" }.to raise_error NoMethodError
    end

    it "returns nil when uninitialized" do
      expect(object.single).to eq nil
    end

    it "returns the value" do
      object.send(:single=, "one")

      expect(object.single).to eq "one"
    end
  end

  describe "#multiple" do
    it "raises because the method is private" do
      expect { object.multiple = ["two", "three"] }.to raise_error NoMethodError
    end

    it "returns empty when uninitialized" do
      expect(object.multiple).to be_empty
    end

    it "returns the value" do
      object.send(:multiple=, ["two", "three"])

      expect(object.multiple).to match_array ["two", "three"]
    end

    it "appends to the array" do
      object.multiple << "four"

      expect(object.multiple).to match_array ["four"]
    end
  end

  describe "#type" do
    it "raises because the method is private" do
      expect { object.type = "1" }.to raise_error NoMethodError
    end

    it "returns nil when uninitialized" do
      expect(object.type).to eq nil
    end

    it "returns the value" do
      object.send(:type=, "1")

      expect(object.type).to eq 1
    end
  end

  describe "#default" do
    it "raises because the method is private" do
      expect { object.default = "value" }.to raise_error NoMethodError
    end

    it "returns the default when uninitialized" do
      expect(object.default).to eq "a_default"
    end

    it "returns the value" do
      object.send(:default=, "value")

      expect(object.default).to eq "value"
    end
  end
end