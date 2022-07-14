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
                unit_price: 4,
                merchant_id: merchant1.id
              })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

      created_item = Item.last

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end
end
