# frozen_string_literal: true

describe Kozo::CLI do
  subject(:cli) { described_class.new(args) }

  # around { |example| suppress_output { example.run } }

  describe "options" do
    describe "--directory" do
      let(:args) { ["--directory", "/foo/bar/.."] }

      it "sets the working directory" do
        cli

        expect(Kozo.options.directory).to eq "/foo"
      end
    end

    describe "--verbose" do
      let(:args) { ["--verbose"] }

      it "turns on verbose output" do
        cli

        expect(Kozo.options).to be_verbose
      end
    end

    describe "--help" do
      let(:args) { ["--help"] }

      it "prints usage and exits" do
        expect { expect { cli }.to raise_error Kozo::ExitError }.to log "[global options]"
      end
    end
  end

  describe "#start" do
    context "when no command is given" do
      let(:args) { [] }

      it "prints usage and exits" do
        expect { expect { cli.start }.to raise_error Kozo::ExitError }.to log "[global options]"
      end
    end

    describe "a command without subcommands" do
      let(:args) { ["init", "foo"] }

      it "instantiates a command" do
        expect(Kozo::Commands::Init)
          .to receive(:new)
          .with("foo")
          .and_call_original

        cli.start
      end

      context "when an invalid command is given" do
        let(:args) { ["foo"] }

        it "prints usage and exits" do
          expect { expect { cli.start }.to raise_error Kozo::ExitError }.to log "[global options]"
        end
      end
    end

    describe "a command with subcommands" do
      let(:args) { ["state", "list", "foo"] }

      it "instantiates a subcommand" do
        expect(Kozo::Commands::State::List)
          .to receive(:new)
          .with("foo")
          .and_call_original

        cli.start
      end

      context "when no subcommand is given" do
        let(:args) { ["state"] }

        it "prints usage and exits" do
          expect { expect { cli.start }.to raise_error Kozo::ExitError }.to log "[global options]"
        end
      end

      context "when an invalid subcommand is given" do
        let(:args) { ["state", "foo"] }

        it "prints usage and exits" do
          expect { expect { cli.start }.to raise_error Kozo::ExitError }.to log "[global options]"
        end
      end
    end
  end
end
