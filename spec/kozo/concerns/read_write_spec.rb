# frozen_string_literal: true

RSpec.describe Kozo::ReadWrite do
  subject(:object) { object_class.new }

  let(:object_class) do
    Class.new do
      include Kozo::Attributes
      include Kozo::ReadWrite

      readwrite

      attribute :readwrite

      readonly

      attribute :readonly

      writeonly

      attribute :writeonly
    end
  end

  it { is_expected.to respond_to :readwrite, :readwrite= }

  it { is_expected.to respond_to :readonly }
  it { is_expected.not_to respond_to :readonly= }

  it { is_expected.not_to respond_to :writeonly }
  it { is_expected.to respond_to :writeonly= }
end
