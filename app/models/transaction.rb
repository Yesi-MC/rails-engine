class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :credit_card_expiration_date, :invoice_id

  enum result: ['success', 'failed']

  belongs_to :invoice
end
