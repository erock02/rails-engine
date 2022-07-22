class Api::V1::MostItemsController < ApplicationController
  def index
    merchants = Merchant.top_merchants_by_items(params[:quantity])
    render json: ItemsSoldSerializer.new(merchants)
  end
end
