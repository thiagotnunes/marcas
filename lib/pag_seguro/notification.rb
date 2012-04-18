module PagSeguro
  class Notification
    attr_reader :status, :reference

    def initialize(reference, status)
      @status = status
      @reference = reference
    end
  end
end
