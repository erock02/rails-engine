class Merchant < ApplicationRecord
  has_many :items

  def self.search_by_name(name)
    Merchant.all
    .where("UPPER(name) LIKE ?", "%#{name.upcase}%")
    .order(:name)
    .limit(1)
  end
end
