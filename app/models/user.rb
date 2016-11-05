class User < ActiveRecord::Base
  validates :name, :uid, :provider, presence: true
  has_many :outfits
  #
  # def self.build_from_facebook(auth_hash)
  #   user       = User.new
  #   user.uid   = auth_hash[:uid]
  #   user.provider = 'github'
  #   user.name  = auth_hash['info']['name']
  #   user.email = auth_hash['info']['email']
  #
  #   return user
  # end

  def self.build_from_facebook(auth_hash)
    user = User.new
    # user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.uid   = auth_hash[:uid]
    user.provider = 'facebook'
    user.name = auth_hash['info']['name']
    user.location = auth_hash['info']['location']
    user.image_url = auth_hash['info']['image']
    user.url = auth_hash['info']['urls'][user.provider.capitalize]
    user.first_name = auth_hash['info']['first_name']
    user.last_name = auth_hash['info']['last_name']
    user.age_range = auth_hash['info']['age_range']
    user.gender = auth_hash['info']['gender']
    
    return user
  end
end
