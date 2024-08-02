class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :cost
      t.integer :quantity
      t.boolean :inventory, null: false

      t.timestamps null: false
    end
  end
end
