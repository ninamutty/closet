class AddOutfitToPhoto < ActiveRecord::Migration
  def change
    add_reference :photos, :outfit, foreign_key: true
  end
end
