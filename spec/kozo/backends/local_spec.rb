# frozen_string_literal: true

RSpec.describe Kozo::Backends::Local do
  subject(:backend) { build(:local_backend) }

  let(:state) { { foo: "bar" } }
  let(:file) { File.join(backend.directory, "kozo.kzstate") }

  describe "#initialize!" do
    it "does not override existing state file" do
      File.write(file, "foo")

      backend.initialize!

      expect(File.read(file)).to eq "foo"
    end

    it "creates a state file if it does not exist" do
      backend.initialize!

      expect(File.read(file)).to eq Kozo::State.new.to_h.deep_stringify_keys.to_yaml
    end
  end

  describe "#data" do
    it "reads a local file" do
      File.write(file, state.to_json)

      expect(backend.data).to eq state
    end
  end

  describe "#data=" do
    it "writes a local file" do
      backend.data = state

      expect(File.read(file)).to eq "---\nfoo: bar\n"
    end

    it "writes a backup file" do
      backend.backups = true

      File.write(file, "---\nbar: foo\n")

      Timecop.freeze do
        backend.data = state

        expect(File.read(file)).to eq "---\nfoo: bar\n"
        expect(File.read("#{file}.#{DateTime.current.to_i}.kzbackup")).to eq "---\nbar: foo\n"
      end
    end
  end

  describe "#file=" do
    it "sets the relative path to the state file" do
      backend.file = "kozo/kozo.kzstate"

      expect(backend.path).to eq File.join(backend.directory, "kozo/kozo.kzstate")
    end
  end
end
