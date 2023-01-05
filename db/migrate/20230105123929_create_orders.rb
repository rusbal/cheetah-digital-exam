class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :guest, null: false, foreign_key: true
      t.string :store_id, null: false
      t.string :transaction_id, null: false
      t.datetime :timestamp, null: false
      t.decimal :discount, precision: 6, scale: 2, default: 0
      t.integer :points, default: 0

      t.timestamps

      t.index [:store_id, :transaction_id], unique: true
    end
  end
end
