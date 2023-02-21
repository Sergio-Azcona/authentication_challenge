class UsersController <ApplicationController 
    before_action :validate_user, only: :show

    def index
    end
    
    def new 
        @user = User.new #needed for strong params
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
        session.destroy #destroy all data from the session
        # session.delete(‘id’) or session[:id] = nil #destroy id but keeps data from the session
        flash[:success] = "Logout Complete!"
        redirect_to root_path
    end

    def create 
        user = User.create(user_params)
        if user.save
            session[:id] = user.id
            flash[:success] = "Welcome, #{user.name}!"
            redirect_to dashboard_path(user)
        else  
            flash[:error] = user.errors.full_messages.to_sentence
            # require 'pry';binding.pry
            redirect_to register_path
        end 
    end 

    private 

    def user_params 
        # require 'pry';binding.pry
        params[:user][:email].downcase!
        # require 'pry';binding.pry
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
end 