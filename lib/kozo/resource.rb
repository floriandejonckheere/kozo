# frozen_string_literal: true

module Kozo
  class Resource
    include Attributes
    include Arguments

    include Assignment
    include Mark
    include Track

    attr_accessor :provider, :state_name

    attribute :id

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
        data: attributes,
      }
    end

    def self.from_h(hash)
      Kozo
        .container
        .resolve("resource.#{hash.dig(:meta, :resource)}")
        .tap { |r| hash[:data].each { |k, v| r.send(:"#{k}=", v) } }
        .tap { |r| r.state_name = hash.dig(:meta, :name) }
    end

    ##
    # Refetch resource from remote infrastructure
    #
    def refresh!
      Kozo.logger.info "#{address}: refreshing state"

      refresh

      Kozo.logger.info "#{address}: refreshed state"
    end

    ##
    # Create resource in remote infrastructure
    #
    def create!
      Kozo.logger.info "#{address}: creating resource"

      create

      Kozo.logger.info "#{address}: created resource"
    end

    ##
    # Update resource in remote infrastructure
    #
    def update!
      Kozo.logger.info "#{address}: updating resource"

      update

      Kozo.logger.info "#{address}: updated resource"
    end

    ##
    # Destroy resource in remote infrastructure
    #
    def destroy!
      Kozo.logger.info "#{address}: destroying resource"

      destroy

      Kozo.logger.info "#{address}: destroyed resource"
    end

    protected

    def refresh
      raise NotImplementedError
    end

    def create
      raise NotImplementedError
    end

    def update
      raise NotImplementedError
    end

    def destroy
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
