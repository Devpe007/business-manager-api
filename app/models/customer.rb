class Customer < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :email, presence: true
  validates :user_id, presence: true
end
