# frozen_string_literal: true

RSpec.describe Kozo::Commands::Version do
  subject(:command) { build(:version_command) }

  it "shows the current application version" do
    expect { command.start }.to log(/kozo #{Kozo::VERSION}/o)
  end
end
