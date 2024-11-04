class Comment < ApplicationRecord
  include Visible
  include ElectionSafe
  
  belongs_to :post
  belongs_to :user
  validates :user, presence: true
  validates :body, presence: true
  validates :status, presence: true
end