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
      # expect(item[:id]).to be_an(Integer)

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
    # expect(item.count).to eq(1)

      expect(item).to have_key(:id)
      # expect(item[:id]).to be_an(Integer)

      expect(item).to have_key(:attributes)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to_not have_key(:created_at)
  end
end
