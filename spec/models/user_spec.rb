require 'spec_helper'
require 'rails_helper'

describe User do
    it 'should respond to is_valid?' do
        test_user = User.new
        expect(test_user).to respond_to :is_valid?
    end

    describe 'creating users' do
        it 'allows a valid user to be created' do
            user = User.create username: 'test user', password: 'test password', email_address: 'test@email.com'
            
            expect(user.persisted?).to be_truthy
        end
    
        it 'prevents users without usernames' do
            user = User.create username: '', password: 'test password', email_address: 'test1@email.com'
            expect(user.persisted?).to be_falsy
            
            user = User.create username: nil, password: 'test password', email_address: 'test2@email.com'
            expect(user.persisted?).to be_falsy
        end
        
        it 'prevents users without passwords' do
            user = User.create username: 'test user1', password: '', email_address: 'test3@email.com'
            expect(user.persisted?).to be_falsy
            
            user = User.create username: 'test user2', password: nil, email_address: 'test4@email.com'   
            expect(user.persisted?).to be_falsy
        end
        
        it 'prevents users without email addresses' do
            user = User.create username: 'test user3', password: 'test password', email_address: ''
            expect(user.persisted?).to be_falsy
            
            user = User.create username: 'test user4', password: 'test password', email_address: nil
            expect(user.persisted?).to be_falsy
        end
        
        it 'prevents users without valid email addresses' do
            user = User.create username: 'test user5', password: 'test password', email_address: 'invalid email'
            expect(user.persisted?).to be_falsy
        end
        
        it 'should not allow duplicate usernames' do
            duplicate_username = 'test user6'
            user = User.create username: duplicate_username, password: 'test password',
            email_address: 'valid@email.com'
            expect(user.persisted?).to be_truthy
            
            user = User.create username: duplicate_username, password: 'test password', email_address: 'valid1@email.com'
            expect(user.persisted?).to be_falsy
        end
        
        it 'should not allow duplicate email addresses' do
            duplicate_email_address = 'duplicate@email.com'
            user = User.create username: 'test user7', password: 'test password', email_address: duplicate_email_address
            expect(user.persisted?).to be_truthy
            
            user = User.create username: 'test user8', password: 'test password', email_address: duplicate_email_address
            expect(user.persisted?).to be_falsy
        end
    end
    
    describe '#is_valid?' do
        it 'should return true if user is stored in database' do
            user = User.create username: 'test user9', password: 'test password', email_address: 'valid2@email.com'
            
            expect(user.is_valid?).to be_truthy
        end
        
        it 'should return false if user is not stored in database' do
            user = User.create username: 'test user10', password: 'test password',email_address: 'invalid'
            
            expect(user.is_valid?).to be_falsy
        end
    end
end