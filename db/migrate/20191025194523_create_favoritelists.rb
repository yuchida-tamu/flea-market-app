class CreateFavoritelists < ActiveRecord::Migration[6.0]
  def change
    create_table :favoritelists do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
