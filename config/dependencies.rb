# frozen_string_literal: true

register("backend.local") do |configuration, directory|
  Kozo::Backends::Local.new(configuration, directory)
end

register("backend.git") do |configuration, directory|
  Kozo::Backends::Git.new(configuration, directory)
end
