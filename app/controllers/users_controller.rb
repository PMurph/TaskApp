class UsersController < ApplicationController
    def new
    end
    
    def create
        created_user = User.create username: params[:username], password: params[:password], email_address: params[:email_address]

        redirect_to_user_creation_response_page created_user
    end
    
    def redirect_to_user_creation_response_page created_user
        if created_user.valid?
            redirect_to action: :creation_successful
        else
            redirect_to action: :new
        end
    end
    
    def creation_successful
    end
    
    private :redirect_to_user_creation_response_page
end
