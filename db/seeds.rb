# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "json"

Movie.destroy_all


url = "https://tmdb.lewagon.com/movie/top_rated"
movies_list_serialized = URI.parse(url).read
movies_list= JSON.parse(movies_list_serialized)

movies_list["results"].each do |movie|
  Movie.create(title: movie["original_title"], overview: movie["overview"], poster_url:"https://image.tmdb.org/t/p/original#{movie["poster_path"]}", rating: movie["vote_average"])
end

puts "Created #{Movie.count} movies"

3.times do
  List.create(name: "recommended by " + Faker::Name.name)
end

Movie.all.each do |movie|
  Bookmark.create!(movie: movie, list: List.all.sample, comment: Faker::Lorem.sentence(word_count: 5))
end

puts "created #{Movie.count} movies"
puts "created #{List.count} lists"
puts "created #{Bookmark.count} links"
