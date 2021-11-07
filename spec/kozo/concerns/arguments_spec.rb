# frozen_string_literal: true

RSpec.describe Kozo::Arguments do
  subject(:object) { object_class.new }

  let(:object_class) do
    Class.new do
      include Kozo::Arguments

      argument :single
      argument :multiple, multiple: true

      argument :type, type: :integer
      argument :default, default: "a_default"
    end
  end

  describe ".argument_names" do
    it "returns the names of the arguments" do
      expect(object_class.argument_names).to match_array [:single, :multiple, :type, :default]
    end
  end

  describe ".argument_types" do
    it "returns the types of the arguments" do
      expect(object_class.argument_types).to include single: include(multiple: false), multiple: include(multiple: true)
    end
  end

  describe "#arguments" do
    it "returns the arguments" do
      object.single = "one"
      object.multiple = ["two", "three"]

      expect(object.arguments).to include single: "one", multiple: ["two", "three"]
    end
  end

  describe "#single" do
    it "raises because the method is private" do
      expect { object.single }.to raise_error NoMethodError
    end

    it "returns nil when uninitialized" do
      expect(object.send(:single)).to eq nil
    end

    it "returns the value" do
      object.single = "one"

      expect(object.send(:single)).to eq "one"
    end
  end

  describe "#multiple" do
    it "raises because the method is private" do
      expect { object.multiple }.to raise_error NoMethodError
    end

    it "returns empty when uninitialized" do
      expect(object.send(:multiple)).to be_empty
    end

    it "returns the value" do
      object.multiple = ["two", "three"]

      expect(object.send(:multiple)).to match_array ["two", "three"]
    end

    it "appends to the array" do
      object.send(:multiple) << "four"

      expect(object.send(:multiple)).to match_array ["four"]
    end
  end

  describe "#type" do
    it "raises because the method is private" do
      expect { object.type }.to raise_error NoMethodError
    end

    it "returns nil when uninitialized" do
      expect(object.send(:type)).to eq nil
    end

    it "returns the value" do
      object.type = "1"

      expect(object.send(:type)).to eq 1
    end
  end

  describe "#default" do
    it "raises because the method is private" do
      expect { object.default }.to raise_error NoMethodError
    end

    it "returns the default when uninitialized" do
      expect(object.send(:default)).to eq "a_default"
    end

    it "returns the value" do
      object.default = "value"

      expect(object.send(:default)).to eq "value"
    end
  end
end
