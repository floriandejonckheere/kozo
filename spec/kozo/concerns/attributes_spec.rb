# frozen_string_literal: true

RSpec.describe Kozo::Attributes do
  subject(:object) { object_class.new }

  let(:object_class) do
    Class.new do
      include Kozo::Attributes

      attribute :single_attribute, argument: false
      attribute :multiple_attribute, multiple: true, argument: false

      attribute :type_attribute, type: :integer, argument: false
      attribute :default_attribute, default: "a_default", argument: false

      attribute :single_argument, attribute: false
      attribute :multiple_argument, multiple: true, attribute: false

      attribute :type_argument, type: :integer, attribute: false
      attribute :default_argument, default: "a_default", attribute: false
    end
  end

  describe "attributes" do
    describe ".attribute_names" do
      it "returns the names of the attributes" do
        expect(object_class.attribute_names).to match_array [:single_attribute, :multiple_attribute, :type_attribute, :default_attribute]
      end
    end

    describe ".attribute_types" do
      it "returns the type_attributes of the attributes" do
        expect(object_class.attribute_types).to include single_attribute: include(multiple: false), multiple_attribute: include(multiple: true)
      end
    end

    describe "#attributes" do
      it "returns the attributes" do
        object.send(:single_attribute=, "one")
        object.send(:multiple_attribute=, ["two", "three"])

        expect(object.attributes).to include single_attribute: "one", multiple_attribute: ["two", "three"]
      end
    end

    describe "#single_attribute" do
      it "raises because the method is private" do
        expect { object.single_attribute = "one" }.to raise_error NoMethodError
      end

      it "returns nil when uninitialized" do
        expect(object.single_attribute).to eq nil
      end

      it "returns the value" do
        object.send(:single_attribute=, "one")

        expect(object.single_attribute).to eq "one"
        expect(object).to be_single_attribute
      end
    end

    describe "#multiple_attribute" do
      it "raises because the method is private" do
        expect { object.multiple_attribute = ["two", "three"] }.to raise_error NoMethodError
      end

      it "returns empty when uninitialized" do
        expect(object.multiple_attribute).to be_empty
      end

      it "returns the value" do
        object.send(:multiple_attribute=, ["two", "three"])

        expect(object.multiple_attribute).to match_array ["two", "three"]
        expect(object).to be_multiple_attribute
      end

      it "appends to the array" do
        object.multiple_attribute << "four"

        expect(object.multiple_attribute).to match_array ["four"]
      end
    end

    describe "#type_attribute" do
      it "raises because the method is private" do
        expect { object.type_attribute = "1" }.to raise_error NoMethodError
      end

      it "returns nil when uninitialized" do
        expect(object.type_attribute).to eq nil
      end

      it "returns the value" do
        object.send(:type_attribute=, "1")

        expect(object.type_attribute).to eq 1
        expect(object).to be_type_attribute
      end
    end

    describe "#default_attribute" do
      it "raises because the method is private" do
        expect { object.default_attribute = "value" }.to raise_error NoMethodError
      end

      it "returns the default_attribute when uninitialized" do
        expect(object.default_attribute).to eq "a_default"
      end

      it "returns the value" do
        object.send(:default_attribute=, "value")

        expect(object.default_attribute).to eq "value"
        expect(object).to be_default_attribute
      end
    end
  end

  describe "arguments" do
    describe ".argument_names" do
      it "returns the names of the arguments" do
        expect(object_class.argument_names).to match_array [:single_argument, :multiple_argument, :type_argument, :default_argument]
      end
    end

    describe "#arguments" do
      it "returns the arguments" do
        object.single_argument = "one"
        object.multiple_argument = ["two", "three"]

        expect(object.arguments).to include single_argument: "one", multiple_argument: ["two", "three"]
      end
    end

    describe "#single_argument" do
      it "raises because the method is private" do
        expect { object.single_argument }.to raise_error NoMethodError
      end

      it "returns nil when uninitialized" do
        expect(object.send(:single_argument)).to eq nil
      end

      it "returns the value" do
        object.single_argument = "one"

        expect(object.send(:single_argument)).to eq "one"
      end
    end

    describe "#multiple_argument" do
      it "raises because the method is private" do
        expect { object.multiple_argument }.to raise_error NoMethodError
      end

      it "returns empty when uninitialized" do
        expect(object.send(:multiple_argument)).to be_empty
      end

      it "returns the value" do
        object.multiple_argument = ["two", "three"]

        expect(object.send(:multiple_argument)).to match_array ["two", "three"]
      end

      it "appends to the array" do
        object.send(:multiple_argument) << "four"

        expect(object.send(:multiple_argument)).to match_array ["four"]
      end
    end

    describe "#type" do
      it "raises because the method is private" do
        expect { object.type_argument }.to raise_error NoMethodError
      end

      it "returns nil when uninitialized" do
        expect(object.send(:type_argument)).to eq nil
      end

      it "returns the value" do
        object.type_argument = "1"

        expect(object.send(:type_argument)).to eq 1
      end
    end

    describe "#default_argument" do
      it "raises because the method is private" do
        expect { object.default_argument }.to raise_error NoMethodError
      end

      it "returns the default when uninitialized" do
        expect(object.send(:default_argument)).to eq "a_default"
      end

      it "returns the value" do
        object.default_argument = "value"

        expect(object.send(:default_argument)).to eq "value"
      end
    end
  end
end
