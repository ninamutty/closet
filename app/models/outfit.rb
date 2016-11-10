class Outfit < ActiveRecord::Base
  has_many :outfit_tags
  has_many :tags, :through => :outfit_tags
  belongs_to :user
  has_many :photos

  has_attached_file :photo, :styles => {:small => '200x100>', :medium => "450x300>", :large => "630x420"}

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
end
