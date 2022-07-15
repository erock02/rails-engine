require 'rails_helper'

RSpec.describe 'The items API' do
  it 'sends a list of items' do
    create_list(:item, 3)

    get '/api/v1/items'

    response_body = JSON.parse(response.body, symbolize_names: true)

    items = response_body[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)

      expect(item).to have_key(:attributes)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to_not have_key(:created_at)
    end
  end

  it 'sends a item with specific ID' do
    create_list(:item, 3)

    get "/api/v1/items/#{Item.first.id}"

    response_body = JSON.parse(response.body, symbolize_names: true)

    item = response_body[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(item).to have_key(:id)
    expect(item).to have_key(:attributes)
    expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to_not have_key(:created_at)
  end

  it 'sends an item to be created' do
    merchant1 = create(:merchant)

    item_params = ({
                name: 'Toothbrush',
                description: 'Helps fight tooth decay',
                unit_price: 4.0,
                merchant_id: merchant1.id
              })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

      created_item = Item.last

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can update an existing item" do
    merchant1 = create(:merchant)
    id = create(:item).id
    previous_name = Item.last.name
    previous_description = Item.last.description
    previous_price = Item.last.unit_price
    item_params = ({
                name: 'Toothbrush',
                description: 'Helps fight tooth decay',
                unit_price: 4.0,
                merchant_id: merchant1.id
              })
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.description).to_not eq(previous_description)
    expect(item.unit_price).to_not eq(previous_price)
    expect(item.name).to eq('Toothbrush')
    expect(item.description).to eq('Helps fight tooth decay')
    expect(item.unit_price).to eq(4.0)
  end

  it "can update an existing item with partial data" do
    merchant1 = create(:merchant)
    id = create(:item).id
    previous_name = Item.last.name
    previous_description = Item.last.description
    previous_price = Item.last.unit_price
    item_params = ({
                name: 'Toothbrush',
                description: 'Helps fight tooth decay',
                merchant_id: merchant1.id
              })
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.description).to_not eq(previous_description)
    expect(item.name).to eq('Toothbrush')
    expect(item.description).to eq('Helps fight tooth decay')
  end

  it "can destory an item" do
    item = create(:item)
    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'sends an items merchant' do
    create_list(:item, 1)

    get "/api/v1/items/#{Item.first.id}/merchant"

    response_body = JSON.parse(response.body, symbolize_names: true)

    merchant = response_body[:data]
    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(merchant).to have_key(:id)
    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes][:name]).to be_a(String)

  end
end
