# frozen_string_literal: true

RSpec.describe Kozo::Backends::Local do
  include FakeFS::SpecHelpers

  subject(:backend) { build(:local_backend) }

  let(:state) { build(:state) }
  let(:file) { File.join(backend.directory, "kozo.kzstate") }

  describe "#initialize!" do
    it "does not override existing state file" do
      File.write(file, "foo")

      backend.initialize!

      expect(File.read(file)).to eq "foo"
    end

    it "creates a state file if it does not exist" do
      backend.initialize!

      expect(File.read(file)).to eq({}.to_json)
    end
  end

  describe "#state" do
    it "reads a local file" do
      File.write(file, state.to_json)

      expect(backend.state).to eq state
    end
  end

  describe "#state=" do
    it "writes a local file" do
      backend.state = state

      expect(File.read(file)).to eq state.to_json
    end
  end
end
