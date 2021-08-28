# frozen_string_literal: true

module Kozo
  class Resource
    include ActiveModel::Attributes
    include ActiveModel::Dirty

    attr_accessor :id, :provider, :state_name

    class_attribute :resource_name, :provider_name

    def address
      "#{resource_name}.#{state_name}"
    end

    def ==(other)
      self.class == other.class &&
        id == other.id &&
        state_name == other.state_name
    end

    alias eql? ==

    def hash
      [self.class, id].hash
    end

    def to_h
      {
        meta: meta,
        data: data,
      }
    end

    def to_dsl
      # Max attribute name length
      l = attribute_names.map(&:length).max || 1

      <<~DSL.chomp
        #{"# #{resource_name}.#{state_name}:".bold}
        resource "#{resource_name}", "#{state_name}" do |r|
          #{data.map { |k, v| "r.#{k.to_s.ljust(l)} = \"#{v.to_s.chomp}\"" }.join("\n  ")}
        end

      DSL
    end

    def self.from_h(hash)
      Kozo
        .container
        .resolve("resource.#{hash.dig(:meta, :resource)}")
        .tap { |r| hash[:data].each { |k, v| r.send(:"#{k}=", v) } }
        .tap { |r| r.state_name = hash.dig(:meta, :name) }
    end

    protected

    ##
    # Collect resource data
    #
    # @return Hash
    #
    def data
      raise NotImplementedError
    end

    ##
    # Refetch resource from remote infrastructure
    #
    def refresh!
      raise NotImplementedError
    end

    ##
    # Create resource in remote infrastructure
    #
    def create!
      raise NotImplementedError
    end

    ##
    # Destroy resource in remote infrastructure
    #
    def destroy!
      raise NotImplementedError
    end

    ##
    # Update resource in remote infrastructure
    #
    def update!
      raise NotImplementedError
    end

    private

    def meta
      {
        name: state_name,
        provider: provider_name,
        resource: resource_name,
      }
    end
  end
end
