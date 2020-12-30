# frozen_string_literal: true

RSpec.describe Kozo::Provider do
  subject(:provider) { described_class.new }

  describe "class methods" do
    subject { described_class }

    it { is_expected.to respond_to :provider_name, :provider_name= }
  end

  describe "#==" do
    subject(:provider) { provider_one_class.new }

    let(:provider_one_class) { Class.new(described_class) { self.provider_name = "provider_one" } }
    let(:provider_two_class) { Class.new(described_class) { self.provider_name = "provider_two" } }

    it { is_expected.to eq provider_one_class.new }
    it { is_expected.not_to eq provider_two_class.new }
  end
end
