# frozen_string_literal: true

register("provider.dummy") do
  Kozo::Providers::Dummy::Provider.new
end

register("resource.dummy") do
  Kozo::Providers::Dummy::Resources::Dummy.new
end
