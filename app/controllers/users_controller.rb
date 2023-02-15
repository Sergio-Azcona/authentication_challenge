class UsersController <ApplicationController 
    before_action :validate_user, only: :show

    def index
    end
    
    def new 
        @user = User.new
    end 

    def show 
        current_user
    end 

    def login_form
        
    end

    def login_user
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
            # require 'pry';binding.pry
            session[:id] = user.id
            # require 'pry';binding.pry
            flash[:success] = "Welcome, #{user.name}!"
            redirect_to dashboard_path(user)
        else
            flash[:error] = "Sorry, your credentials are bad."
            render :login_form
        end
    end

    def logout_user
        # require 'pry';binding.pry
        session.destroy
        flash[:success] = "Logout Complete!"
        redirect_to root_path
    end

    def create 
        user = User.create(user_params)
        if user.save
            session[:id] = user.id
            flash[:success] = "Welcome, #{user.name}!"
            redirect_to user_path(user)
        else  
            flash[:error] = user.errors.full_messages.to_sentence
            redirect_to register_path
        end 
    end 

    private 

    def user_params 
        params[:user][:email].downcase!
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
end 