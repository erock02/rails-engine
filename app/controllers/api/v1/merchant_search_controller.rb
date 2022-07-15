class Api::V1::MerchantSearchController < ApplicationController
  def index
    @merchant = Merchant.search_by_name(params[:name])
    if @merchant == []
      payload = {
                  data: {},
                  error: 'null'
                }
    render :json => payload, :status => 200
    else
      render json: MerchantSerializer.new(@merchant[0])
    end
  end
end
