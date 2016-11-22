class LastWornToDate < ActiveRecord::Migration
  def change
    remove_column :outfits, :last_worn, :datetime
    add_column :outfits, :last_worn, :date
  end
end
