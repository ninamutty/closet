# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

CSV.foreach("seeds_csvs/outfits.csv", :headers => true) do |csv_obj|
  Outfit.create(id: csv_obj['id'].to_i, name: csv_obj['name'], last_worn: csv_obj['last_worn'], category: csv_obj['category'], reworn_count: csv_obj['reworn_count'], favorite: csv_obj['favorite'], photo: csv_obj['photo'])
end
