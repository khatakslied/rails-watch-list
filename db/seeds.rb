require 'open-uri'
require 'json'

url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=987db1965f59b1afa8d4f0943b6b6584'
movies = JSON.parse(URI.open(url).read)

puts "Clearing database..."
Movie.destroy_all

puts "Adding movies to database..."
movies["results"].each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500/#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
end
