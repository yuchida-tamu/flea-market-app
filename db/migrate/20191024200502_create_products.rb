class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 15, scale: 3
      t.text :info
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
