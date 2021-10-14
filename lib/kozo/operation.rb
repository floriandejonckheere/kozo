# frozen_string_literal: true

module Kozo
  class Operation
    attr_reader :resource

    class_attribute :symbol, :display_symbol

    def initialize(resource)
      @resource = resource
    end

    def apply(_state)
      raise NotImplementedError
    end

    def to_s
      # Max attribute name length
      l = resource.attribute_names.map(&:length).max || 1

      <<~DSL.chomp
        #{"# #{resource.address}:".bold}
        #{display_symbol} resource "#{resource.resource_name}", "#{resource.state_name}" do |r|
          #{resource.attributes.map { |k, v| "#{resource.changes.key?(k) ? display_symbol : ' '}  r.#{k.to_s.ljust(l)} = \"#{v.to_s.chomp.truncate(75)}\"" }.join("\n  ")}
        end

      DSL
    end
  end
end
