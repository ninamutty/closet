class Photo < ActiveRecord::Base
  belongs_to :outfit


  has_attached_file :image, :styles => {:small => '200x100>', :medium => "450x300>", :large => "630x420"},
    storage: :s3,
    s3_credentials: {access_key_id: ENV["AWS_KEY"], secret_access_key: ENV["AWS_SECRET"]},
    bucket: ENV["AWS_BUCKET"]


  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
