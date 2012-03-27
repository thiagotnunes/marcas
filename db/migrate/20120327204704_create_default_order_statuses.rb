class CreateDefaultOrderStatuses < ActiveRecord::Migration
  def up
    OrderStatus.create!(status: "Aguardando pagamento", first_status: 1, color: "progress-danger")
    OrderStatus.create!(status: "Em registro", first_status: 0, color: "progress-warning")
    OrderStatus.create!(status: "Concluido", first_status: 0, color: "progress-success")
  end

  def down
    OrderStatus.find_by_status("Aguardando pagamento").destroy
    OrderStatus.find_by_status("Em registro").destroy
    OrderStatus.find_by_status("Concluido").destroy
  end
end
