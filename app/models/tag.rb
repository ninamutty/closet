class Tag < ActiveRecord::Base
  has_many :outfit_tags
  has_many :outfits, :through => :outfit_tags
end
