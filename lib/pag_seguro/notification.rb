module PagSeguro
  class Notification
    attr_reader :status

    def initialize(reference, status)
      @status = status
      @reference = reference
    end

    def reference
      @reference.to_i
    end
  end
end
