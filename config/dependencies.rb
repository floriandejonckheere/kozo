# frozen_string_literal: true

##
# Backends
#
register("backend.local") do |directory|
  Kozo::Backends::Local.new(directory)
end

##
# Providers
#
register("provider.null") do
  Kozo::Providers::Null::Provider.new
end

register("provider.hcloud") do
  Kozo::Providers::HCloud::Provider.new
end

##
# Resources
#
register("resource.null") do
  Kozo::Providers::Null::Resources::Null.new
end
