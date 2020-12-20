# frozen_string_literal: true

require "tmpdir"

RSpec.describe Kozo::Workspace do
  subject(:workspace) { described_class.new(directory) }

  let(:directory) { Dir.mktmpdir }
  let(:file) { "" }

  before do
    File.write(File.join(directory, "one.kz"), file)
    File.write(File.join(directory, "two.kz"), file)
  end

  after { FileUtils.remove_entry directory }

  it "defaults to local backend" do
    expect(workspace.backend).to be_a Kozo::Backends::Local
  end
end
