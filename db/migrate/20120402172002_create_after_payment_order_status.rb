class CreateAfterPaymentOrderStatus < ActiveRecord::Migration
  def up
    OrderStatus.create!(status: "Aguardando confirmacao de pagamento", after_payment: 1, color: "progress-warning")
  end

  def down
    OrderStatus.find_by_status("Aguardando confirmacao de pagamento").destroy
  end
end
