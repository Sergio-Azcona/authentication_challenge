class MoviesFacade
  
  def self.top_rated
    data = MovieService.top_rated_results
    # require 'pry';binding.pry
    data[:results].map do |movie|
      MovieInfo.new(movie)
    end
  end

    def self.search_movies(keywords)
      data = MovieService.search_movies_by(keywords)
      # require 'pry';binding.pry
      data[:results].map do |movie|
        MovieInfo.new(movie)
      end
    end


end