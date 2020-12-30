# frozen_string_literal: true

register("provider.hcloud") do
  Kozo::Providers::HCloud::Provider.new
end

register("resource.hcloud_ssh_key") do
  Kozo::Providers::HCloud::Resources::SSHKey.new
end
