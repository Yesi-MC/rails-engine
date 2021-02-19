require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
  end
  describe 'methods' do 
   xit 'can get revenue sorted by top selling merchants' do 
    merchant1 = Merchant.create!(name: 'Hair Care')
    merchant2 = Merchant.create!(name: 'Jewelry')

    customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    customer_2 = Customer.create!(first_name: 'Cecilia', last_name: 'Jones')
    customer_3 = Customer.create!(first_name: 'Mariah', last_name: 'Carrey')
    customer_4 = Customer.create!(first_name: 'Leigh Ann', last_name: 'Bron')
    customer_5 = Customer.create!(first_name: 'Sylvester', last_name: 'Nader')
    customer_6 = Customer.create!(first_name: 'Herber', last_name: 'Coon')
    
    invoice_1 = Invoice.create!(merchant_id: merchant1.id, customer_id: customer_1.id, status: 0)
    invoice_2 = Invoice.create!(merchant_id: merchant1.id, customer_id: customer_1.id, status: 0)
    invoice_3 = Invoice.create!(merchant_id: merchant1.id, customer_id: customer_2.id, status: 0)
    invoice_4 = Invoice.create!(merchant_id: merchant1.id, customer_id: customer_5.id, status: 0)
    invoice_5 = Invoice.create!(merchant_id: merchant1.id, customer_id: customer_6.id, status: 1)

    item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: merchant1.id)
    item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: merchant1.id)
    item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: merchant1.id)
    item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: merchant1.id)
    item_5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: merchant2.id)
    item_6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: merchant2.id)
    item_7 = Item.create!(name: "Scrunchie", description: "This holds up your hair but is bigger", unit_price: 3, merchant_id: merchant1.id)
    item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: merchant1.id)

    inv_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 9, unit_price: 10 )
    inv_item_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_1.id, quantity: 1, unit_price: 10 )
    inv_item_3 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_2.id, quantity: 2, unit_price: 8 )
    inv_item_4 = InvoiceItem.create!(invoice_id: invoice_4.id, item_id: item_3.id, quantity: 3, unit_price: 5 )
    inv_item_6 = InvoiceItem.create!(invoice_id: invoice_5.id, item_id: item_4.id, quantity: 1, unit_price: 1 )

    transaction1 = Transaction.create!(credit_card_number: 203123, credit_card_expiration_date: '04/23', result: 0, invoice_id:invoice_1.id)
    transaction2 = Transaction.create!(credit_card_number: 230456, credit_card_expiration_date: '04/23', result: 0, invoice_id:invoice_2.id)
    transaction3 = Transaction.create!(credit_card_number: 123456, credit_card_expiration_date: '04/23', result: 0, invoice_id:invoice_3.id)
    transaction4 = Transaction.create!(credit_card_number: 021536, credit_card_expiration_date: '04/23', result: 0, invoice_id:invoice_4.id)
    transaction5 = Transaction.create!(credit_card_number: 789456, credit_card_expiration_date: '04/23', result: 1, invoice_id:invoice_5.id)

    expect(Merchant.merch_by_desc_revenue(2)).to eq([merchant1, merchant2])
    end
  end
end
