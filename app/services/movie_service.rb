class MovieService
  def self.top_rated_results
    response = conn.get("/3/movie/top_rated?")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.search_movies_by(keyword)
    response = conn.get('/3/search/movie?') do |search|
      search.params['query'] = keyword
    end
      
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    conn = Faraday.new('https://api.themoviedb.org') do |f|
      f.params["api_key"] = ENV['api_key']
      f.params["language"] = 'en-US' #limiting return by value
      f.params['include_adult'] = 'false'
      # f.params["page"] = '1'
    end
  end
end