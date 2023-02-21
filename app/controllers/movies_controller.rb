class MoviesController < ApplicationController
    # before_action :validate_user, only: :show #do we need this here? NO?

    def index 
        @user = User.find_by(params[:id])
        @searched = params[:search_keywords]

        if @searched
            # require 'pry';binding.pry
            @movies = MoviesFacade.search_movies(@searched).first(20)
        else
            @movies = MoviesFacade.top_rated.first(20)
        end
        # require 'pry';binding.pry
    end 

    def show 
        @user = User.find(params[:user_id])
        @movie = Movie.find(params[:id])
    end 
end 