class CreateOrderStatuses < ActiveRecord::Migration
  def change
    create_table :order_statuses do |t|
      t.string :status
      t.text :description
      t.string :color

      t.timestamps
    end
  end
end
