class AddAttachmentPhotoToOutfits < ActiveRecord::Migration
  def self.up
    change_table :outfits do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :outfits, :photo
  end
end
