class Users < ActiveRecord::Base
    has_many :games
end