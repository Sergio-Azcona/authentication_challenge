class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @user = User.find(session[:id]) if (session[:id])
  end

  def validate_user
    if !current_user
      # require 'pry';binding.pry
      flash[:error] = "Must be a registered user for access"
      redirect_to login_path 
    end
  end

end
