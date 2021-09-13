# frozen_string_literal: true

module Kozo
  module Dirty
    def mark_for_deletion!
      @status = :delete
    end

    def marked_for_deletion?
      @status == :delete
    end

    def mark_for_creation!
      @status = :create
    end

    def marked_for_creation?
      @status == :create
    end

    def unmark!
      @status = nil
    end
  end
end
