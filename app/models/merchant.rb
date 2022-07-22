class Merchant < ApplicationRecord
  has_many(:items)
  has_many(:invoices)
  has_many(:invoice_items, through: :invoices)
  has_many(:customers, through: :invoices)
  has_many(:transactions, through: :invoices)

  def self.search_by_name(name)
    Merchant.all
    .where("UPPER(name) LIKE ?", "%#{name.upcase}%")
    .order(:name)
    .limit(1)
  end

  def self.top_merchants_by_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .select(:name, :id, 'SUM(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group(:id).order(revenue: :desc)
    .limit(quantity)
  end

  def self.top_merchants_by_items(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .select(:name, :id, 'SUM(invoice_items.quantity) as count')
    .group(:id)
    .order('count DESC')
    .limit(quantity)
  end
end
