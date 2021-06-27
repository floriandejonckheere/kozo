# frozen_string_literal: true

register("backend.local") do |configuration, directory|
  Kozo::Backends::Local.new(configuration, directory)
end
