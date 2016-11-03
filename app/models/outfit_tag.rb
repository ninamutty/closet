class OutfitTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :outfit
end
