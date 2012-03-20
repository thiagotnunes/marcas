class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.references :order_type

      t.timestamps
    end
    add_index :services, :order_type_id
  end
end
