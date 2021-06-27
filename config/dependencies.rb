# frozen_string_literal: true

register("environment") do |directory|
  Kozo::Environment.new(directory)
end

register("backend.local") do |configuration, directory|
  Kozo::Backends::Local.new(configuration, directory)
end
