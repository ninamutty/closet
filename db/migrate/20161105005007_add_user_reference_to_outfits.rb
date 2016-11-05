class AddUserReferenceToOutfits < ActiveRecord::Migration
  def change
    add_reference :outfits, :user, foreign_key: true
  end
end
