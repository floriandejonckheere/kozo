# frozen_string_literal: true

RSpec.describe Kozo::Resource do
  subject(:resource) { described_class.new }

  it { is_expected.to respond_to :id, :id= }
end
