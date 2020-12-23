# frozen_string_literal: true

RSpec.describe Kozo::Provider do
  subject(:provider) { described_class.new }

  it "has a name" do
    expect(described_class).to respond_to :name, :name=
  end
end
