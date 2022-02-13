# frozen_string_literal: true

RSpec.describe Kozo::Inflector do
  subject(:inflector) { described_class.new(Kozo.root.join("lib/kozo.rb")) }

  describe "#camelize" do
    it "camelizes file names" do
      expect(inflector.camelize("kozo", "lib/kozo")).to eq "Kozo"
    end

    it "camelizes upgrades" do
      expect(inflector.camelize("1_initial", "lib/kozo/upgrade")).to eq "Initial"
    end
  end
end
