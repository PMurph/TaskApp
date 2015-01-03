class UsersController < ApplicationController
    skip_before_filter :verify_authenticity_token, only: [:create] # Allows for creation of new users without causing an error thrown due to missing token

    def new
    end
    
    def create
        if !User.is_password_valid? params[:password], params[:retyped_password]
            redirect_to_user_creation_failure_page
            return
        end
        
        new_user = User.create username: params[:username], password: params[:password], email_address: params[:email_address]
        
        if !new_user.valid?
            redirect_to_user_creation_failure_page
            return
        end

        redirect_to action: :creation_successful
    end
    
    def redirect_to_user_creation_failure_page
        redirect_to action: :new
    end
    
    def creation_successful
    end
    
    private :redirect_to_user_creation_failure_page
end
