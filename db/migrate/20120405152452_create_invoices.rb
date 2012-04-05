class CreateInvoices < ActiveRecord::Migration
  def up
    create_table :invoices do |t|
    end
  end

  def down
    drop_table :invoices
  end
end
