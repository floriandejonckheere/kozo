# frozen_string_literal: true

RSpec.describe Kozo::Parser do
  subject(:parser) { described_class.new(directory) }

  let(:directory) { Dir.mktmpdir }

  let(:dsl) { double }

  before do
    # Write ignore file
    File.write(File.join(directory, ".kzignore"), "zzz.kz")

    # Write configuration
    File.write(File.join(directory, "main.kz"), "main\n")

    File.write(File.join(directory, "ccc.kz"), "ccc\n")
    File.write(File.join(directory, "aaa.kz"), "aaa\n")
    File.write(File.join(directory, "bbb.kz"), "bbb\n")
    File.write(File.join(directory, "zzz.kz"), "zzz\n")

    # Mock DSL
    allow(Kozo::DSL).to receive(:new).and_return dsl
  end

  it "loads main.kz, then other files alphabetically and ignores patterns in .kzignore" do
    expect(dsl).to receive(:main).ordered
    expect(dsl).to receive(:aaa).ordered
    expect(dsl).to receive(:bbb).ordered
    expect(dsl).to receive(:ccc).ordered
    expect(dsl).not_to receive(:zzz).ordered

    parser.call
  end
end
