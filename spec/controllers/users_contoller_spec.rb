require 'spec_helper'
require 'rails_helper'

describe UsersController do
    it 'should respond to the new method call' do
        expect(@controller).to respond_to :new
    end
    
    it 'should respond to the create method call' do
        expect(@controller).to respond_to :create
    end

    describe '#new' do
        before(:each) do
            get :new
        end
        
        it 'should respond with success' do
            expect(response).to be_success
        end
        
        it 'should render the new view' do
            expect(response).to render_template :new
        end
    end
    
    describe '#create' do
        before(:each) do
            @test_username = 'test_user'
            @test_password = 'password'
            @test_valid_email = 'test@email.com'
            
            @valid_user = create_user_double true
            @invalid_user = create_user_double false
        end
        
        def create_user_double valid
            user_double = double('user')
            allow(user_double).to receive(:valid?) { valid }
            
            user_double
        end
        
        it 'should attempt to create a new user using the parameters passed' do
            allow(User).to receive(:create) { @valid_user }
            allow(User).to receive(:is_password_valid?) { true }
            expect(User).to receive(:create).with username: @test_username, password: @test_password, email_address: @test_valid_email
            
            make_create_post_request_to_controller
        end
        
        it 'should check if the created user is valid' do
            allow(User).to receive(:create) { @valid_user }
            allow(User).to receive(:is_password_valid?) { true }
            expect(@valid_user).to receive(:valid?)
            
            make_create_post_request_to_controller
        end
        
        it 'should check if the password is valid' do
            test_password1 = 'password1'
            test_password2 = 'password2'
        
            allow(User).to receive(:create) { @valid_user }
            allow(User).to receive(:is_password_valid?) { true }
            expect(User).to receive(:is_password_valid?).with test_password1, test_password2
            
            make_create_post_request_to_controller test_password1, test_password2
        end
        
        it 'should redirect to users/new page if password validation fails' do
            allow(User).to receive(:create) { @valid_user }
            allow(User).to receive(:is_password_valid?) { false }
            
            make_create_post_request_to_controller
            expect(@controller).to redirect_to action: :new
        end
        
        it 'should redirect to usercreated page if successful' do
            allow(User).to receive(:create) { @valid_user }
            allow(User).to receive(:is_password_valid?) { true }
            
            make_create_post_request_to_controller
            expect(@controller).to redirect_to action: :creation_successful
        end
        
        it 'should redirect to users/new page if unsuccessful' do
            allow(User).to receive(:create) { @invalid_user }
            allow(User).to receive(:is_password_valid?) { true }
            
            make_create_post_request_to_controller
            expect(@controller).to redirect_to action: :new
        end
        
        def make_create_post_request_to_controller test_password=@test_password, test_retyped_password=@test_password
            post :create, username: @test_username, password: test_password, retyped_password: test_retyped_password, email_address: @test_valid_email
        end
    end
end