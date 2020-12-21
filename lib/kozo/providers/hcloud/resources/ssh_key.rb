# frozen_string_literal: true

module Kozo
  module Providers
    module HCloud
      module Resources
        class SSHKey < Kozo::Resource
          attr_accessor :name, :public_key
        end
      end
    end
  end
end
