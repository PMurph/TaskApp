class User < ActiveRecord::Base
    validates :username, presence: true
    validates_uniqueness_of :username
    
    validates :password, presence: true
    
    validates :email_address, presence: true
    validates_uniqueness_of :email_address
    validates_format_of :email_address, with: /\A[A-Za-z0-9]+(.[A-Za-z0-9]+)*@([A-Za-z0-9]+.)*[A-Za-z0-9]+\Z/i # This only matches a portion of the valid emails TODO: Fix to match specifications at http://en.wikipedia.org/wiki/Email_address
    
    def self.is_password_valid? password, retyped_password
        password == retyped_password
    end
    
    def self.verify_and_create_user username, password, retyped_password, email_address
        raise(ArgumentError, "Passwords #{password} and #{retyped_password} do not match") if !User.is_password_valid? password, retyped_password
        
        user = User.create username: username, password: password, email_address: email_address
        raise(ArgumentError, "Invalid username(#{username}) or email address(#{email_address})") if !user.valid?
        
        user
    end
    
    def self.can_login? username, password
        user = User.find_by username: username, password: password
        return user != nil && user.email_verified
    end
end
