class Product < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :price, presence: true
  validate :cost
  validate :quantity
  validates :inventory, presence: true
end
