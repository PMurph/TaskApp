require 'spec_helper'
require 'rails_helper'

describe User do
    it 'should respond to verify_password?' do
        expect(User).to respond_to :is_password_valid?
        expect(User).to respond_to :verify_and_create_user
    end
    
    describe 'creating users' do
        it 'allows a valid user to be created' do
            user = User.create username: 'test user', password: 'test password', email_address: 'test@email.com'
            
            expect(user.valid?).to be_truthy
        end
    
        it 'prevents users without usernames' do
            user = User.create username: '', password: 'test password', email_address: 'test1@email.com'
            expect(user.valid?).to be_falsy
            
            user = User.create username: nil, password: 'test password', email_address: 'test2@email.com'
            expect(user.valid?).to be_falsy
        end
        
        it 'prevents users without passwords' do
            user = User.create username: 'test user1', password: '', email_address: 'test3@email.com'
            expect(user.valid?).to be_falsy
            
            user = User.create username: 'test user2', password: nil, email_address: 'test4@email.com'   
            expect(user.valid?).to be_falsy
        end
        
        it 'prevents users without email addresses' do
            user = User.create username: 'test user3', password: 'test password', email_address: ''
            expect(user.valid?).to be_falsy
            
            user = User.create username: 'test user4', password: 'test password', email_address: nil
            expect(user.valid?).to be_falsy
        end
        
        it 'prevents users without valid email addresses' do
            user = User.create username: 'test user5', password: 'test password', email_address: 'invalid email'
            expect(user.valid?).to be_falsy
        end
        
        it 'should not allow duplicate usernames' do
            duplicate_username = 'test user6'
            user = User.create username: duplicate_username, password: 'test password',
            email_address: 'valid@email.com'
            expect(user.valid?).to be_truthy
            
            user = User.create username: duplicate_username, password: 'test password', email_address: 'valid1@email.com'
            expect(user.valid?).to be_falsy
        end
        
        it 'should not allow duplicate email addresses' do
            duplicate_email_address = 'duplicate@email.com'
            user = User.create username: 'test user7', password: 'test password', email_address: duplicate_email_address
            expect(user.valid?).to be_truthy
            
            user = User.create username: 'test user8', password: 'test password', email_address: duplicate_email_address
            expect(user.valid?).to be_falsy
        end
    end
    
    describe '#is_password_valid?' do
        it 'should return true when password is valid' do
            valid_password = 'TestP@SSworD3'
            
            expect(User.is_password_valid? valid_password, valid_password).to be_truthy
        end
        
        it 'should return false if password and retyped password are not equal' do
            expect(User.is_password_valid? 'Th15 P@ssword', 'Th@t Pa55word').to be_falsy
        end
    end
    
    describe '#verify_and_create_user' do
        before(:each) do
            @username = 'test_user'
            @password = 'password123'
            @email_address = 'fake@fakemail.com'
        end
    
        it 'should return a valid user when valid parameters are passed' do
            user = User.verify_and_create_user @username, @password, @password, @email_address
            
            expect(user.valid?).to be_truthy
        end
        
        it 'should raise an Error if invalid parameters are passed' do
            expect{ User.verify_and_create_user @username, @password, 'other', @email_address }.to raise_error(ArgumentError)
            
            expect{ User.verify_and_create_user @username, @password, @password, 'bad email' }.to raise_error(ArgumentError)
        end
    end
end