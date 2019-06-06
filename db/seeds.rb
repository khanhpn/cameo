# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Category.delete_all
# User.delete_all
# TallentCategory.delete_all

# ["categories", "users", "tallent_categories"].each do |table_name|
#   ActiveRecord::Base.connection.execute("TRUNCATE #{table_name} RESTART IDENTITY")
# end

[
  "actors", "broadway", "comedians", "comic-con",
  "disney", "game-of-thrones", "harry-potter",
  "lord-of-the-rings", "models", "mtv", "musicians",
  "netflix", "reality", "star-wars", "twilight",
  "video-games", "voice-actors", "animals",
  "athletes", "drag-queens", "en-espanol",
  "family", "fashion", "featured", "for-charity",
  "influencers", "media", "new", "politics",
  "realhousewives", "television", "wrestlers", "youtubers"
].each do |category|
  cat = Category.find_by(name: category)
  cat.update(type_web: "cameo") if cat.present?
  Category.create({name: category, type_web: "cameo"})
end
