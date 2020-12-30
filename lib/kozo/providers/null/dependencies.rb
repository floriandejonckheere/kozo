# frozen_string_literal: true

register("provider.null") do
  Kozo::Providers::Null::Provider.new
end

register("resource.null") do
  Kozo::Providers::Null::Resources::Null.new
end
