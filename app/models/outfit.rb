class Outfit < ActiveRecord::Base

  has_attached_file :photo, :styles => {:medium => "300x200>"}

  validates_attachment_content_type :photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
