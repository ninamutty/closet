class AddReferenceToPhoto < ActiveRecord::Migration
  def change
    remove_column :photos, :user_id, :integer
    add_reference :photos, :user, foreign_key: true
  end
end
