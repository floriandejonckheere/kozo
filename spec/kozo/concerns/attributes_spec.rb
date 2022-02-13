# frozen_string_literal: true

RSpec.describe Kozo::Attributes do
  subject(:object) { object_class.new }

  let(:object_class) do
    Class.new do
      include Kozo::Attributes
      include Kozo::ReadWrite

      attribute :single
      attribute :multiple, multiple: true
      attribute :type, type: :integer
      attribute :default, default: "a_default"
      attribute :boolean, type: :boolean, default: true
      attribute :wrapped, wrapped: true

      readonly

      attribute :readonly

      writeonly

      attribute :writeonly
    end
  end

  describe ".attribute_types" do
    it "returns the types of the attributes" do
      expect(object_class.attribute_types).to include single: include(multiple: false), multiple: include(multiple: true)
    end
  end

  describe ".attribute_names" do
    it "returns the names of the attributes" do
      expect(object_class.attribute_names).to match_array [:single, :multiple, :type, :default, :boolean, :wrapped, :readonly, :writeonly]
    end
  end

  describe ".readable_attribute_names" do
    it "returns the names of the arguments" do
      expect(object_class.readable_attribute_names).not_to include :writeonly
    end
  end

  describe ".writeable_attribute_names" do
    it "returns the names of the arguments" do
      expect(object_class.writeable_attribute_names).not_to include :readonly
    end
  end

  describe "#attributes" do
    it "returns the attributes" do
      object.single = "one"
      object.multiple = ["two", "three"]
      object.send(:readonly=, "four")

      expect(object.attributes).to include single: "one", multiple: ["two", "three"], readonly: "four"
    end
  end

  describe "#readable_attributes" do
    it "returns the arguments" do
      object.writeonly = "one"

      expect(object.readable_attributes).not_to include writeonly: "one"
    end
  end

  describe "#writeable_attributes" do
    it "returns the arguments" do
      object.send(:readonly=, "one")

      expect(object.writeable_attributes).not_to include readonly: "one"
    end
  end

  describe "#single" do
    it "returns nil when uninitialized" do
      expect(object.single).to eq nil
    end

    it "returns the value" do
      object.single = "one"

      expect(object.single).to eq "one"
      expect(object).to be_single
    end
  end

  describe "#multiple" do
    it "returns empty when uninitialized" do
      expect(object.multiple).to be_empty
    end

    it "returns the value" do
      object.multiple = ["two", "three"]

      expect(object.multiple).to match_array ["two", "three"]
      expect(object).to be_multiple
    end

    it "appends to the array" do
      object.multiple << "four"

      expect(object.multiple).to match_array ["four"]
    end
  end

  describe "#type" do
    it "returns nil when uninitialized" do
      expect(object.type).to eq nil
    end

    it "returns the value" do
      object.type = "1"

      expect(object.type).to eq 1
      expect(object).to be_type
    end
  end

  describe "#default" do
    it "returns the default when uninitialized" do
      expect(object.default).to eq "a_default"
    end

    it "returns the value" do
      object.default = "value"

      expect(object.default).to eq "value"
      expect(object).to be_default
    end

    it "returns a default attribute for boolean types" do
      object.boolean = false

      expect(object.boolean).to eq false
    end
  end

  describe "#wrapped" do
    it "unwraps the value" do
      object.wrapped = OpenStruct.new(name: "value")

      expect(object.wrapped).to eq "value"

      object.wrapped = "another_value"

      expect(object.wrapped).to eq "another_value"
    end
  end

  describe "#readonly" do
    it { is_expected.to respond_to :readonly }
    it { is_expected.not_to respond_to :readonly= }
  end

  describe "#writeonly" do
    it { is_expected.not_to respond_to :readonly= }
    it { is_expected.to respond_to :readonly }
  end
end
