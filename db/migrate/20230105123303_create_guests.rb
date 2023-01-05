class CreateGuests < ActiveRecord::Migration[6.1]
  def change
    create_table :guests do |t|
      t.string :string_id, null: false

      t.timestamps
    end
  end
end
