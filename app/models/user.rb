class User < ApplicationRecord
    validates :username, presence: { message: "cannot be empty" },
                        uniqueness: true
    has_many :posts
    has_many :comments
end
