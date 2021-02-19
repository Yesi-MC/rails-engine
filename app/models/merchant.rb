class Merchant < ApplicationRecord
  validates_presence_of :name 
  has_many :items 
  has_many :invoices

  has_many :invoice_items, through: :invoices 


  def self.merch_by_desc_revenue(quantity)
    joins(invoice_items: {invoice: :transactions})
    .where("invoice.status='shipped' AND transaction.result='success'")
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .group(:id).order("revenue DESC")
    .limit(quantity)
  end
end
