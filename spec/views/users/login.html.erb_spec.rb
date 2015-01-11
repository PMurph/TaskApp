require 'spec_helper'
require 'rails_helper'

describe 'users/login' do
    before(:each) do
        render template: 'users/login.html.erb'
    end
    
    it 'should have text "Login"' do
        expect(rendered).to include "Login"
    end
    
    it 'should have a form with id user_login_form' do
        expect(rendered).to have_selector "form#user_login_form"
    end
    
    it 'should have a form with labels "Username", and "Password"' do
        expect(rendered).to have_selector "form#user_login_form label", text: "Username"
        expect(rendered).to have_selector "form#user_login_form label", text: "Password"
    end
    
    it 'should have inputs with ids "username", and "password"' do
        expect(rendered).to have_selector "form#user_login_form input#username"
        expect(rendered).to have_selector "form#user_login_form input#password"
        expect(rendered).to have_selector "form#user_login_form input#login"
    end
end
