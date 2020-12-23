# frozen_string_literal: true

RSpec.describe Kozo::Backends::Local do
  subject(:backend) { build(:local_backend) }

  let(:state) { build(:state) }
  let(:file) { File.join(backend.directory, "kozo.kzstate") }

  describe "#initialize" do
    it "does not override existing state file" do
      allow(File)
        .to receive(:exist?)
        .with(file)
        .and_return true

      expect(File)
        .not_to have_received(:write)
        .with(file, any_args)

      backend.initialize!
    end

    it "creates a state file if it does not exist" do
      allow(File)
        .to receive(:exist?)
        .with(file)
        .and_return false

      expect(File)
        .to have_received(:write)
        .with(file, any_args)

      backend.initialize!
    end
  end

  describe "#state" do
    it "reads a local file" do
      allow(File)
        .to receive(:exist?)
        .with(file)
        .and_return true

      allow(File)
        .to receive(:read)
        .with(file, any_args)
        .and_return state.to_json

      expect(backend.state).to eq state
    end
  end

  describe "#state=" do
    it "writes a local file" do
      allow(File)
        .to receive(:write)
        .with(file, state.to_json, any_args)

      backend.state = state
    end
  end
end
