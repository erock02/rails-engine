class Item < ApplicationRecord
  belongs_to :merchant

  def self.search_all_by_name(name)
    Item.all
    .where("UPPER(name) LIKE ?", "%#{name.upcase}%")
    # .order(:name)
    # .limit(1)
  end
end
