# frozen_string_literal: true

RSpec.describe Kozo::Attributes do
  subject(:object) { object_class.new }

  let(:object_class) do
    Class.new do
      include Kozo::Attributes

      attribute :single_attribute
      attribute :multiple_attribute, multiple: true
      attribute :type_attribute, type: :integer
      attribute :default_attribute, default: "a_default"
      attribute :boolean_attribute, type: :boolean, default: true

      attribute :create_attribute, only: :create
      attribute :read_attribute, only: :read
      attribute :update_attribute, only: :update
      attribute :delete_attribute, only: :delete
      attribute :none_attribute, only: :none
    end
  end

  describe "uses" do
    it { is_expected.not_to respond_to :create_attribute }
    it { is_expected.to respond_to :create_attribute= }

    it { is_expected.to respond_to :read_attribute }
    it { is_expected.not_to respond_to :read_attribute= }

    it { is_expected.not_to respond_to :update_attribute }
    it { is_expected.to respond_to :update_attribute= }

    it { is_expected.not_to respond_to :delete_attribute }
    it { is_expected.to respond_to :delete_attribute= }

    it { is_expected.not_to respond_to :none_attribute }
    it { is_expected.not_to respond_to :none_attribute= }
  end

  describe ".attribute_names" do
    it "returns the names of the attributes" do
      expect(object_class.attribute_names).to match_array [:single_attribute, :multiple_attribute, :type_attribute, :default_attribute, :boolean_attribute, :read_attribute]
    end
  end

  describe ".attribute_types" do
    it "returns the type_attributes of the attributes" do
      expect(object_class.attribute_types).to include single_attribute: include(multiple: false), multiple_attribute: include(multiple: true)
    end
  end

  describe "#attributes" do
    it "returns the attributes" do
      object.single_attribute = "one"
      object.multiple_attribute = ["two", "three"]

      expect(object.attributes).to include single_attribute: "one", multiple_attribute: ["two", "three"]
    end
  end

  describe ".argument_names" do
    it "returns the names of the arguments" do
      expect(object_class.argument_names).to match_array [:create_attribute, :update_attribute, :delete_attribute]
    end
  end

  describe "#arguments" do
    it "returns the arguments" do
      object.create_attribute = "one"

      expect(object.arguments).to include create_attribute: "one"
    end
  end

  describe "#single_attribute" do
    it "returns nil when uninitialized" do
      expect(object.single_attribute).to eq nil
    end

    it "returns the value" do
      object.single_attribute = "one"

      expect(object.single_attribute).to eq "one"
      expect(object).to be_single_attribute
    end
  end

  describe "#multiple_attribute" do
    it "returns empty when uninitialized" do
      expect(object.multiple_attribute).to be_empty
    end

    it "returns the value" do
      object.multiple_attribute = ["two", "three"]

      expect(object.multiple_attribute).to match_array ["two", "three"]
      expect(object).to be_multiple_attribute
    end

    it "appends to the array" do
      object.multiple_attribute << "four"

      expect(object.multiple_attribute).to match_array ["four"]
    end
  end

  describe "#type_attribute" do
    it "returns nil when uninitialized" do
      expect(object.type_attribute).to eq nil
    end

    it "returns the value" do
      object.type_attribute = "1"

      expect(object.type_attribute).to eq 1
      expect(object).to be_type_attribute
    end
  end

  describe "#default_attribute" do
    it "returns the default_attribute when uninitialized" do
      expect(object.default_attribute).to eq "a_default"
    end

    it "returns the value" do
      object.default_attribute = "value"

      expect(object.default_attribute).to eq "value"
      expect(object).to be_default_attribute
    end

    it "returns a default attribute for boolean types" do
      object.boolean_attribute = false

      expect(object.boolean_attribute).to eq false
    end
  end
end
