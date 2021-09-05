# frozen_string_literal: true

require "English"
require "fileutils"

# rubocop:disable RSpec/BeforeAfterAll, RSpec/InstanceVariable
RSpec.describe "Hetzner Cloud", integration: true, order: :defined do
  before(:all) do |_example|
    @directory = Dir.mktmpdir

    # Set up working directory (shared files)
    FileUtils.cp_r Kozo.root.join("spec/fixtures/hcloud/shared/."), @directory
  end

  after(:all) do |_example|
    # Tear down working directory
    FileUtils.rm_r @directory
  end

  before do |example|
    # Set up working directory (fixtures)
    FileUtils.cp_r Kozo.root.join("spec/fixtures/hcloud/#{example.metadata[:fixture]}/."), @directory if example.metadata[:fixture]
  end

  around do |example|
    Dir.chdir(@directory) { example.run }
  end

  it "initializes state" do
    `kozo init`

    expect(File).to exist File.join(@directory, "kozo.kzstate")
  end

  it "plans resource creation", fixture: "ssh_key" do
    output = `kozo plan`

    expect($CHILD_STATUS.exitstatus).to be_zero
    expect(output.uncolorize).to include "+ hcloud_ssh_key.default"
  end
end
# rubocop:enable RSpec/BeforeAfterAll, RSpec/InstanceVariable
