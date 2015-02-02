require 'spec_helper'
require 'rails_helper'

describe UsersController do
    it 'should respond to the new method call' do
        expect(@controller).to respond_to :new
    end
    
    it 'should respond to the create method call' do
        expect(@controller).to respond_to :create
    end

    it 'should respond to the show method call' do
        expect(@controller).to respond_to :show
    end
    
    it 'should respond to the edit method call' do
        expect(@controller).to respond_to :edit
    end
    
    it 'should respond to the update method call' do
        expect(@controller).to respond_to :update
    end
    
    it 'should respond to the delete method call' do
        expect(@controller).to respond_to :destroy
    end
    
    it 'should respond to the login method call' do
        expect(@controller).to respond_to :login
    end
    
    it 'should respond to the verify_login method call' do
        expect(@controller).to respond_to :verify_login
    end
    
    it 'should respond to the logout method call' do
        expect(@controller).to respond_to :logout
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
        end
        
        def create_user_double valid
            user_double = double('user')
            allow(user_double).to receive(:valid?) { valid }
            
            user_double
        end
        
        it 'should attempt to create a new user using the parameters passed' do
            allow(User).to receive(:verify_and_create_user) { @valid_user }
            allow(User).to receive(:is_password_valid?) { true }
            expect(User).to receive(:verify_and_create_user).with  @test_username, @test_password, @test_password, @test_valid_email
            
            make_create_post_request_to_controller
        end
        
        it 'should redirect to usercreated page if user is successfully created' do
            allow(User).to receive(:verify_and_create_user) { @valid_user }
            allow(User).to receive(:is_password_valid?) { true }
            
            make_create_post_request_to_controller
            expect(@controller).to redirect_to action: :creation_successful
        end
        
        it 'should redirect to users/new page if unsuccessful' do
            allow(User).to receive(:verify_and_create_user).and_raise(ArgumentError, 'test')
            allow(User).to receive(:is_password_valid?) { true }
            
            make_create_post_request_to_controller
            expect(@controller).to redirect_to action: :new
        end
        
        def make_create_post_request_to_controller test_password=@test_password, test_retyped_password=@test_password
            post :create, username: @test_username, password: test_password, retyped_password: test_retyped_password, email_address: @test_valid_email
        end
    end
    
    describe '#login' do
        before(:each) do
            get :login
        end
        
        it 'should respond with success' do
            expect(response).to be_success
        end
        
        it 'should render the login template' do
            expect(response).to render_template :login
        end
    end
    
    describe '#verify_login' do
        describe 'invalid users information' do
            before(:each) do
                allow(User).to receive(:can_login?) { false }
                post :verify_login, username: "invalid", password: "invalid"
            end
            
            it 'should redirect to the login page if user is invalid' do
                expect(@controller).to redirect_to action: :login
            end
            
            it 'should not assign anything to the :user session variable is invalid user information is passed' do
                expect(session[:user]).to be_falsy
            end
        end
        
        describe 'valid user information' do
            before(:each) do
                @username = "valid"
                allow(User).to receive(:can_login?) { true }
                post :verify_login, username: @username, password: "valid"
            end
            
            it 'should redirect to the root of the app if user is valid' do
                expect(controller).to redirect_to :root
            end
            
            it 'should set the :user session variable if valid user' do
                expect(session[:user]).to be_truthy
            end
        
            it 'should set the :user session variable should have a :username key and the username stored with it' do
                expect(session[:user][:username]).to eq(@username)
            end
        
            it 'should set the :user session variable should have a :auth key' do
                expect(session[:user][:auth]).to be_truthy
            end
        end
    end
    
    describe '#logout' do
        before(:each) do
            session[:user] = {username: "test", auth: "test"}
        
            post :logout
        end
        
        it 'should clear the :user session variable on successful logout' do
            expect(session[:user]).to be_falsy
        end
        
        it 'should redirect to root of the app' do
            expect(@controller).to redirect_to :root
        end
    end
end