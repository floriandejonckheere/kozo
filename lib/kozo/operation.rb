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
      resource_to_s
    end

    protected

    def resource_to_s
      <<~DSL.chomp
        #{"# #{resource.address}:".bold}
        #{display_symbol} resource "#{resource.resource_name}", "#{resource.state_name}" do |r|
          #{attributes_to_s}
        end

      DSL
    end

    def attributes_to_s
      l = resource.attribute_names.map(&:length).max || 1

      resource
        .attributes
        .map { |k, v| "#{resource.changes.key?(k) ? display_symbol : ' '}  r.#{k.to_s.ljust(l)} = #{v.as_s}" }
        .join("\n  ")
    end
  end
end
