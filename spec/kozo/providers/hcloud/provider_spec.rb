# frozen_string_literal: true

RSpec.describe Kozo::Providers::HCloud::Provider do
  subject(:provider) { described_class.new }

  it { is_expected.to respond_to :key, :key= }
end
