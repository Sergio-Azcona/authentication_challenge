class MovieInfo
  attr_reader :id, :title, :vote_average, :overview,
              :genre_ids, :popularity, :poster_path
  def initialize(movie_data)
    @id = movie_data[:id]
    @title = movie_data[:title]
    @vote_average = movie_data[:vote_average]
    @overview = movie_data[:overview]
    @genre_ids = movie_data[:genre_ids]
    @popularity = movie_data[:popularity]
    @poster_path = movie_data[:poster_path]
  end

  def rating_descending
    require 'pry';binding.pry
    # @vote_average.desc
  end
end