# frozen_string_literal: true

##
# Backends
#
register("backend.local") do |directory|
  Kozo::Backends::Local.new(directory)
end

##
# Null provider
#
register("provider.null") do
  Kozo::Providers::Null::Provider.new
end

register("resource.null") do
  Kozo::Providers::Null::Resources::Null.new
end

##
# HCloud
#
register("provider.hcloud") do
  Kozo::Providers::HCloud::Provider.new
end

register("resource.hcloud_ssh_key") do
  Kozo::Providers::HCloud::Resources::SSHKey.new
end
