class CreateOutfitTags < ActiveRecord::Migration
  def change
    create_table :outfit_tags do |t|
      t.references :tag, index: true, foreign_key: true
      t.references :outfit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
