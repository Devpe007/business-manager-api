class PurchaseOrder < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  belongs_to :product
end
