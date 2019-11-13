class Games < ActiveRecord::Base
    belongs_to :users

    validates :name, presence: true
    validates :genre, presence: true
end