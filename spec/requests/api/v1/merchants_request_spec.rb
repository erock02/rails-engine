require 'rails_helper'

RSpec.describe 'The merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    response_body = JSON.parse(response.body, symbolize_names: true)

    merchants = response_body[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant[:attributes]).to_not have_key(:created_at)
    end
  end

  it 'sends a merchant with specific ID' do
    create_list(:merchant, 3)

    get "/api/v1/merchants/#{Merchant.first.id}"

    response_body = JSON.parse(response.body, symbolize_names: true)

    merchant = response_body[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)

      expect(merchant).to have_key(:id)
      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant[:attributes]).to_not have_key(:created_at)
  end

  it 'sends a merchants items' do
    create_list(:item, 5)
    get "/api/v1/merchants/#{Merchant.first.id}/items"

    response_body = JSON.parse(response.body, symbolize_names: true)

    items = response_body[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    items.each do |item|
      expect(item).to have_key(:attributes)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end

  it 'finds a merchant by name' do
    create_list(:merchant, 3)

    get "/api/v1/merchants/find?name=#{Merchant.last.name[0, 1]}"

    response_body = JSON.parse(response.body, symbolize_names: true)

    merchant = response_body[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes][:name]).to eq(Merchant.last.name)
  end

end
