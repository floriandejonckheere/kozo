# frozen_string_literal: true

RSpec.describe Kozo::Commands::State do
  let(:resource) { build(:dummy_resource, id: "dummy", state_name: "dummy") }
  let(:state) { build(:state, resources: [resource]) }

  let(:address) { resource.address }

  describe Kozo::Commands::State::List do
    subject(:command) { build(:state_list_command, state: state) }

    it "lists all resources in the state" do
      expect { command.start }.to log("dummy.dummy")
    end
  end

  describe Kozo::Commands::State::Show do
    subject(:command) { build(:state_show_command, state: state, args: "dummy.dummy") }

    it "shows a resource in the state" do
      expect { command.start }.to log(/id *= "dummy"/)
    end

    context "when the resource does not exist" do
      let(:address) { "foo.bar" }

      it "raises an error" do
        expect { command.start }.to raise_error Kozo::StateError
      end
    end
  end

  describe Kozo::Commands::State::Delete do
    subject(:command) { build(:state_delete_command, state: state, args: address) }

    it "deletes a resource from the state" do
      expect(state.resources).not_to be_empty

      expect { command.start }.to log("dummy.dummy")

      expect(state.resources).to be_empty
    end

    context "when the resource does not exist" do
      let(:address) { "foo.bar" }

      it "raises an error" do
        expect { command.start }.to raise_error Kozo::StateError
      end
    end
  end
end
