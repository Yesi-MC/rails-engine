require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true) 

    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Numeric)
    end 
  end
  it "can get one items by its id" do 
    id = create(:item).id 

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to eq(id.to_s)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_a(Numeric)
  end
  it "can create a new item" do 
    merchant_id = create(:merchant).id 

    item_params = ({
                  name: 'ipad',
                  description: 'is a mini computer', 
                  unit_price: 150.00, 
                  merchant_id: merchant_id
                  })

    headers = {"CONTENT_TYPE" => "application/json"}  
      
    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)
    created_item = Item.last

    expect(response).to be_successful

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(merchant_id)
  end
  it "can update an existing item" do 
    id = create(:item).id 
    previous_name = Item.last.name
    item_params = { name: "ipod nano" }
    headers = {"CONTENT_TYPE" => "application/json"}
    
    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("ipod nano")
  end
  it "can destory an item" do 
    item = create(:item)

    expect(Item.count).to eq(1)

    expect { delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
  it "can get the merchant data for given item id" do 
    id = create(:item).id
    item = create(:item)
      2.times do 
        Merchant.create!(name: Faker::Company.name)
     end

    get "/api/v1/items/#{item.id}/merchant" 

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_a(String)

    expect(item[:data]).to have_key(:type)
    expect(item[:data][:type]).to be_a(String)

    expect(item[:data]).to have_key(:attributes)
    expect(item[:data][:attributes]).to be_a(Hash)

    item_data = item[:data][:attributes]

    expect(item_data).to have_key(:name)
    expect(item_data[:name]).to be_a(String)
  end 
  it "can only have 20 per page" do
     create_list(:item, 30)
 
    get '/api/v1/items?page=1'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true) 

    expect(items[:data].count).to eq(20)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Numeric)
    end 
  end 
  it "can get one merchant by search term" do 
    merchant1 = Merchant.create!(name: 'Apple')
    item1 = Item.create!(name: 'Ipad', description: 'like a mini computer', unit_price: 120.50, merchant_id: merchant1.id)
    item2 = Item.create!(name: 'Ipad Pro', description: 'better mini computer', unit_price: 122.55, merchant_id: merchant1.id)
    item3 = Item.create!(name: 'Ipod Shuffle', description: 'listen to tunes', unit_price: 125.55, merchant_id: merchant1.id)

    get '/api/v1/items/find_all?name=ipA'
    
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true) 

    expect(items[:data].count).to eq(2)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Numeric)
    end 
  end
end 