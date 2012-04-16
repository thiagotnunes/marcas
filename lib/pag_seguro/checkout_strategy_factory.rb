module PagSeguro
  class CheckoutStrategyFactory
    PRODUCTION = "production"

    def strategy_for(environment)
      if environment == PRODUCTION
        return PagSeguro::CheckoutStrategy.new
      else
        return PagSeguro::FakeCheckoutStrategy.new
      end
    end
  end
end
