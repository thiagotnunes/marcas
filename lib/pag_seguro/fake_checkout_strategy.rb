module PagSeguro
  class FakeCheckoutStrategy
    FILE_PATH = File.join(Rails.root, "tmp", "pagseguro-#{Rails.env}.yml")

    def url_for(order)
      FileUtils.touch(FILE_PATH) unless File.exist?(FILE_PATH)

      orders = YAML.load_file(FILE_PATH) || {}

      orders[order.invoice.id] = order.pagseguro_billing_data.except("reference")

      File.open(FILE_PATH, "w+") do |f|
        f << orders.to_yaml
      end

      PagSeguro.config["return_to"]
    end
  end
end
