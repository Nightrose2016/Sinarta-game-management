class Users < ActiveRecord::Base
    has_many :games
    has_secure_password
    validates :username, presence: true
    
    def slug
        self.username.downcase.gsub(" ", "-")
    end
end