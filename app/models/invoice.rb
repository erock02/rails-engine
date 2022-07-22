class Invoice < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :transactions
end
