# frozen_string_literal: true

RSpec.describe Kozo::Commands::State do
  describe Kozo::Commands::State::List do
    subject(:command) { build(:state_list_command, state: state) }

    let(:resource) { build(:null_resource, id: "null", state_name: "null") }
    let(:state) { build(:state, resources: [resource]) }

    it "lists all resources in the state" do
      expect { command.start }.to output("null.null\n").to_stdout
    end
  end

  describe Kozo::Commands::State::Show do
    subject(:command) { build(:state_show_command, state: state, args: "null.null") }

    let(:resource) { build(:null_resource, id: "null", state_name: "null") }
    let(:state) { build(:state, resources: [resource]) }

    it "shows a resource in the state" do
      expect { command.start }.to output(/id = "null"/).to_stdout
    end
  end
end
