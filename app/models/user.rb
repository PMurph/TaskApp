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
end
