class CreateDefaultOrderTypes < ActiveRecord::Migration
  def up
    OrderType.create!(:name => "Marcas")
    OrderType.create!(:name => "Dominios")
    OrderType.create!(:name => "Patentes")
    OrderType.create!(:name => "Direitos autorais")
  end

  def down
    OrderType.find_by_name("Marcas").destroy
    OrderType.find_by_name("Dominios").destroy
    OrderType.find_by_name("Patentes").destroy
    OrderType.find_by_name("Direitos autorais").destroy
  end
end
