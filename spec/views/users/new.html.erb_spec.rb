require 'spec_helper'
require 'rails_helper'

describe 'users/new' do
    before(:each) do
        render template: 'users/new.html.erb'
    end
    
    it 'should display create new user label' do
        expect(rendered).to include 'Create New User'
    end
    
    it 'should contain a form tag with id attribute "user_creation_form"' do
        expect(rendered).to have_selector 'form#user_creation_form'
    end
    
    it 'should have a form with "Username", "Password", "Retype Password" and "Email Address" labels' do
        expect(rendered).to have_selector 'form#user_creation_form label', text: "Username"
        expect(rendered).to have_selector 'form#user_creation_form label', text: "Password"
        expect(rendered).to have_selector 'form#user_creation_form label', text: "Retype Password"
        expect(rendered).to have_selector 'form#user_creation_form label', text:
        "Email Address"
    end
    
    it 'should have a for with inputs for username, password, retyped password, email addresses and creating the user' do
        expect(rendered).to have_selector 'form#user_creation_form input#username'
        expect(rendered).to have_selector 'form#user_creation_form input#password'
        expect(rendered).to have_selector 'form#user_creation_form input#retyped_password'
        expect(rendered).to have_selector 'form#user_creation_form input#email_address'
        expect(rendered).to have_selector 'form#user_creation_form input#create_user'
    end
end