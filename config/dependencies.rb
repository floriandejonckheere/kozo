# frozen_string_literal: true

register("backend.local") do |directory|
  Kozo::Backends::Local.new(directory)
end
