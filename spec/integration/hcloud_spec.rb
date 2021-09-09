# frozen_string_literal: true

require "English"
require "fileutils"

# rubocop:disable RSpec/BeforeAfterAll, RSpec/InstanceVariable
RSpec.describe "Hetzner Cloud", integration: true, order: :defined do
  before(:all) do |_example|
    @directory = Dir.mktmpdir

    # Set up working directory (shared files)
    FileUtils.cp_r Kozo.root.join("spec/fixtures/hcloud/shared/."), @directory

    # Set HCloud client
    HCloud::Client.connection = HCloud::Client.new(access_token: ENV.fetch("HCLOUD_TOKEN"))
  end

  after(:all) do |_example|
    # Tear down working directory
    FileUtils.rm_r @directory

    # Delete resources
    HCloud::SSHKey.all.each(&:delete)
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

  it "creates an SSH key", fixture: "ssh_key_one" do
    output = `kozo plan`

    expect($CHILD_STATUS.exitstatus).to be_zero
    expect(output.uncolorize).to include "+ hcloud_ssh_key.default"

    `kozo apply --yes`

    expect($CHILD_STATUS.exitstatus).to be_zero
    expect(HCloud::SSHKey.all.first.name).to eq "default"
  end

  it "updates an SSH key", fixture: "ssh_key_two" do
    output = `kozo plan`

    expect($CHILD_STATUS.exitstatus).to be_zero
    expect(output.uncolorize).to include "~ hcloud_ssh_key.default"

    `kozo apply --yes`

    expect($CHILD_STATUS.exitstatus).to be_zero
    expect(HCloud::SSHKey.all.first.name).to eq "new_default"
  end

  it "removes an SSH key", fixture: "ssh_key_three" do
    output = `kozo plan`

    expect($CHILD_STATUS.exitstatus).to be_zero
    expect(output.uncolorize).to include "- hcloud_ssh_key.default"

    `kozo apply --yes`

    expect($CHILD_STATUS.exitstatus).to be_zero
    expect(HCloud::SSHKey.all).to be_empty
  end
end
# rubocop:enable RSpec/BeforeAfterAll, RSpec/InstanceVariable
