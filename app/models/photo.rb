class Photo < ActiveRecord::Base
  belongs_to :outfit


  has_attached_file :image, :styles => {:small => '200x100>', :medium => "450x300>", :large => "630x420"}

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
