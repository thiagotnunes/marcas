class CreateTrademarkOrders < ActiveRecord::Migration
  def change
    create_table :trademark_orders do |t|
      t.string :name
      t.string :segment
      t.string :subsegment
      t.text :observations

      t.timestamps
    end
  end
end
