# frozen_string_literal: true

register("configuration") do |directory|
  Kozo::Configuration.new(directory)
end

register("state") do |resources|
  Kozo::State.new(resources)
end

register("backend.local") do |configuration, directory|
  Kozo::Backends::Local.new(configuration, directory)
end
