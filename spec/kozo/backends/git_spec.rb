# frozen_string_literal: true

RSpec.describe Kozo::Backends::Git do
  subject(:backend) { build(:git_backend) }

  let(:state) { { foo: "bar" } }
  let(:repository) { File.join(backend.directory, "kozo.git") }
  let(:file) { File.join(backend.directory, "kozo.git", "kozo.kzstate") }

  describe "#initialize!" do
    it "does not override existing state file" do
      Dir.mkdir(repository)
      File.write(file, "foo")

      backend.initialize!

      expect(File.read(file)).to eq "foo"
    end

    it "creates a state file if it does not exist" do
      backend.initialize!

      expect(File.read(file)).to eq Kozo::State.new.to_h.deep_stringify_keys.to_yaml
    end

    it "creates a git repository" do
      backend.initialize!

      expect(Dir).to exist(File.join(repository, ".git"))
    end

    it "creates a commit" do
      backend.initialize!

      expect(commits).to eq 1
    end

    it "adds a remote" do
      # Create dummy remote
      remote = Dir.mktmpdir
      `git init --bare #{remote} &> /dev/null`

      backend.remote = remote
      backend.initialize!

      expect(Dir.chdir(repository) { `git remote -v` }).to include remote
    end
  end

  describe "#data" do
    before { backend.initialize! }

    it "reads a local file" do
      File.write(file, state.to_json)

      expect(backend.data).to eq state
    end
  end

  describe "#data=" do
    before { backend.initialize! }

    it "writes a local file" do
      backend.data = state

      expect(File.read(file)).to eq "---\nfoo: bar\n"
    end

    it "creates a commit" do
      backend.data = state

      expect(commits).to eq 2
    end

    context "when the fingerprint is the same" do
      it "does not write a local file" do
        backend.data = state

        File.unlink(file)

        backend.data = state

        expect(File).not_to exist file
      end

      it "does not create a commit" do
        backend.data = state

        File.unlink(file)

        backend.data = state

        expect(commits).to eq 2
      end
    end
  end

  def commits
    Dir
      .chdir(repository) { `git rev-list HEAD --count` }
      .chomp
      .to_i
  end
end
