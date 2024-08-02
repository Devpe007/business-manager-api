class CreatePurchaseOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_orders, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :customer, null: false, foreign_key: true, type: :uuid
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.integer :quantity
      t.string :description

      t.timestamps null: false
    end
  end
end
