class AddUserReferenceToTag < ActiveRecord::Migration
  def change
    add_reference :tags, :user, foreign_key: true
  end
end
