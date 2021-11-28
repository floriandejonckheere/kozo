# frozen_string_literal: true

RSpec.describe Kozo::Assignment do
  subject(:object) { object_class.new }

  let(:object_class) do
    Class.new do
      include Kozo::Attributes

      include Kozo::Assignment

      attribute :attribute
    end
  end

  describe "#initialize" do
    it "assigns arguments" do
      object = object_class.new(argument: "an_argument")

      expect(object.send(:argument)).to eq "an_argument"
    end

    it "assigns attributes" do
      object = object_class.new(attribute: "an_attribute")

      expect(object.attribute).to eq "an_attribute"
    end
  end

  describe "#assign_attributes" do
    it "assigns arguments" do
      object.assign_attributes(argument: "an_argument")

      expect(object.send(:argument)).to eq "an_argument"
    end

    it "assigns attributes" do
      object.assign_attributes(attribute: "an_attribute")

      expect(object.attribute).to eq "an_attribute"
    end
  end
end
