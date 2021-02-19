require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'   
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true) 

    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end 
  end
  it "can get one merchant by its id" do 
    id = create(:merchant).id 

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to eq(id.to_s)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
  it "can get all items by its given id" do 
    id = create(:merchant).id
    merchant = create(:merchant)
      3.times do 
        Item.create!(
      name: Faker::Lorem.word,
      description: Faker::Lorem.sentence,
      unit_price: Faker::Number.decimal(l_digits: 2),
      merchant_id: merchant.id
    )
     end

    get "/api/v1/merchants/#{merchant.id}/items" 
    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    merchant_items = merchant[:data]

    merchant_items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)
    end 
  end
  it "can only have 20 per page" do
    create_list(:merchant, 20)
 
    get '/api/v1/merchants?page=1'  
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true) 

    expect(merchants[:data].count).to eq(20)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end 
  end 
  it "can get one merchant by search term" do 
    merchant1 = Merchant.create!(name: 'Amazon')
    merchant2 = Merchant.create!(name: 'Alibaba')

    get '/api/v1/merchants/find?name=aMa'
    
    merchant = JSON.parse(response.body, symbolize_names: true) 
    
    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end 