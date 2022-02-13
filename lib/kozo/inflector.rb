# frozen_string_literal: true

module Kozo
  class Inflector < Zeitwerk::GemInflector
    def camelize(basename, abspath)
      return super(Regexp.last_match(2), abspath) if basename =~ /\A(\d+)_(.*)/ && abspath.include?("kozo/upgrade")

      super
    end
  end
end
