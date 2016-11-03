class Outfit < ActiveRecord::Base

  has_attached_file :photo, :styles => {:small => '200x100>', :medium => "300x200>"}

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
end
