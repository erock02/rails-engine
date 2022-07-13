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
      # expect(merchant[:id]).to be_an(Integer)

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
    # expect(merchant.count).to eq(1)

      expect(merchant).to have_key(:id)
      # expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant[:attributes]).to_not have_key(:created_at)
  end
end
