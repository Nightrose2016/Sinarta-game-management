class User < ActiveRecord::Base
    has_many :games
    has_secure_password
    validates :username, uniqueness: { message: "%{value} is already in use.  Please select another or login."}
    validates :username, presence: true
    validates :password, presence: true
    
end