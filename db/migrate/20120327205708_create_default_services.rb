class CreateDefaultServices < ActiveRecord::Migration
  def up
    id = OrderType.find_by_name("Marcas").id

    Service.create!(name: "Pesquisa de anterioridade", price: 1000, order_type_id: id) 
    Service.create!(name: "Registro de marca", price: 1000, order_type_id:id) 
    Service.create!(name: "Registro de logotipo", price: 1000, order_type_id: id) 
    Service.create!(name: "Registro de marca e logotipo", price: 1000, order_type_id: id) 
  end

  def down
    Service.find_by_name("Pesquisa de anterioridade").destroy
    Service.find_by_name("Registro de marca").destroy
    Service.find_by_name("Registro de logotipo").destroy
    Service.find_by_name("Registro de marca e logotipo").destroy
  end
end
