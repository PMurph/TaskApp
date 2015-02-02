class UsersController < ApplicationController
    skip_before_filter :verify_authenticity_token, only: [:create] # Allows for creation of new users without causing an error thrown due to missing token

    def new
    end
    
    def create
        begin
            new_user = User.verify_and_create_user params[:username], params[:password], params[:retyped_password], params[:email_address]
            redirect_to action: :creation_successful
        rescue ArgumentError
            redirect_to action: :new
        end
    end
    
    def creation_successful
    end
    
    def show
    end
    
    def edit
    end
    
    def update
    end
    
    def destroy
    end
    
    def login
    end
    
    def verify_login
        # This is very insecure, and will change later
        username = params[:username]
        password = params[:password]
        if User.can_login? username, password
            set_user_session username, password
            redirect_to :root
        else
            redirect_to action: :login
        end
    end
    
    def set_user_session username, password
        session[:user] = {username: username, auth: password}
    end
    
    def logout
        session[:user] = nil
        redirect_to :root
    end
    
    private :set_user_session
end
