class MoviesController < ApplicationController
    # before_action :validate_user, only: :show #do we need this here? NO?

    def index 
        # require 'pry';binding.pry
        @user = User.find(params[:id])
        @movies = Movie.all
    end 

    def show 
        @user = User.find(params[:user_id])
        @movie = Movie.find(params[:id])
    end 
end 