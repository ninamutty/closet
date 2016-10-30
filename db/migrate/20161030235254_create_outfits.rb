class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.string :name
      t.datetime :last_worn
      t.string :category
      t.integer :reworn_count
      t.boolean :favorite

      t.timestamps null: false
    end
  end
end
