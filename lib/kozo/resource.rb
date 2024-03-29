# frozen_string_literal: true

module Kozo
  class Resource
    include Attributes
    include Assignment
    include Track
    include ReadWrite

    attr_accessor :provider, :state_name

    readonly

    attribute :id

    readwrite

    class_attribute :resource_name, :provider_name

    class_attribute :creatable_attribute_names,
                    :updatable_attribute_names,
                    default: []

    def address
      "#{resource_name}.#{state_name}"
    end

    # Catchall for id, also works when the resource will be deleted
    def rid
      id || id_was
    end

    def ==(other)
      self.class == other.class &&
        rid == other.rid &&
        state_name == other.state_name
    end

    alias eql? ==

    def hash
      [self.class, id].hash
    end

    def to_dsl(prefix = nil)
      l = attribute_names.map(&:length).max || 1

      attribute_dsl = attributes
        .map { |k, v| "  #{changes.key?(k) ? prefix : '  '}r.#{k.to_s.ljust(l)} = #{v.as_s.indent(4)[4..]}" }
        .join("\n")

      <<~DSL.chomp
        #{"# #{address}:".bold}
        #{prefix}resource "#{resource_name}", "#{state_name}" do |r|
        #{attribute_dsl}
        end

      DSL
    end

    def to_h
      {
        meta: meta,
        data: readable_attributes,
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

      create unless Kozo.options.dry_run?

      Kozo.logger.info "#{address}: created resource"
    end

    ##
    # Update resource in remote infrastructure
    #
    def update!
      Kozo.logger.info "#{address}: updating resource"

      update unless Kozo.options.dry_run?

      Kozo.logger.info "#{address}: updated resource"
    end

    ##
    # Destroy resource in remote infrastructure
    #
    def destroy!
      Kozo.logger.info "#{address}: destroying resource"

      destroy unless Kozo.options.dry_run?

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
