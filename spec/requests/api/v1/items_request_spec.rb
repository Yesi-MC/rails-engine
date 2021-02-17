require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true) 

    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      expect(item[:attributes]).to have_key(:id)
      expect(item[:attributes][:id]).to be_an(Integer)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Numeric)
    end 
  end
  # it "can get one merchant by its id" do 
  #   id = create(:merchant).id 

  #   get "/api/v1/merchants/#{id}"

  #   merchant = JSON.parse(response.body, symbolize_names: true)

  #   expect(response).to be_successful

  #   expect(merchant[:data][:attributes]).to have_key(:id)
  #   expect(merchant[:data][:attributes][:id]).to eq(id)

  #   expect(merchant[:data][:attributes]).to have_key(:name)
  #   expect(merchant[:data][:attributes][:name]).to be_a(String)
  # end
end 