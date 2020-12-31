# frozen_string_literal: true

RSpec.describe Kozo::Attribute do
  subject(:object) { object_class.new }

  let(:object_class) do
    Class.new do
      include Kozo::Attribute

      attribute :foo
      attribute :bar
    end
  end

  it { is_expected.to respond_to :foo, :foo?, :foo= }
  it { is_expected.to respond_to :bar, :bar?, :bar= }

  it "tracks changes" do
    object.foo = "bar"

    expect(object).to be_changed
    expect(object).to be_foo_changed
    expect(object).not_to be_bar_changed
  end

  describe "#save" do
    it "clears changed status" do
      object.foo = "bar"
      object.save

      expect(object).not_to be_changed
    end

    it "persists values" do
      object.foo = "bar"
      object.save

      expect(object.foo).to eq "bar"
    end
  end

  describe "#reload!" do
    it "clears changed status" do
      object.foo = "bar"
      object.reload!

      expect(object).not_to be_changed
    end

    it "reloads values" do
      object.foo = "bar"
      object.reload!

      expect(object.foo).to eq "bar"
    end
  end

  describe "#rollback!" do
    it "restores values" do
      object.foo = "bar"
      object.rollback!

      expect(object.foo).to be_nil
    end
  end
end
