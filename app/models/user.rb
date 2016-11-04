class User < ActiveRecord::Base
  validates :name, :uid, :provider, presence: true

  # def self.build_from_facebook(auth_hash)
  #   user       = User.new
  #   user.uid   = auth_hash[:uid]
  #   user.provider = 'github'
  #   user.name  = auth_hash['info']['name']
  #   user.email = auth_hash['info']['email']
  #
  #   return user
  # end

  def from_omniauth_facebook(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.location = auth_hash['info']['location']
    user.image_url = auth_hash['info']['image']
    user.url = auth_hash['info']['urls'][user.provider.capitalize]
    user.save!

    return user
  end
end


user.url = auth_hash['info']['urls'][user.provider.capitalize]
