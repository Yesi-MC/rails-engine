require 'rails_helper'

describe "Revenue" do
  xit "can get revenue sorted by top selling merchants" do 
    merchant1 = Merchant.create!(name: 'Amazon')
    merchant2 = Merchant.create!(name: 'Alibaba')

    get '/api/v1/revenue/merchants?quantity=10'
    
    merchant = JSON.parse(response.body, symbolize_names: true) 
    
    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end