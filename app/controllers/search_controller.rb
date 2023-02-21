class SearchController < ApplicationController
  def discover
    # require 'pry';binding.pry
    @user = User.find_by(id: params[:id])
  end

end