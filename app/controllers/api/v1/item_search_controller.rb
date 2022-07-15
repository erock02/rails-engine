class Api::V1::ItemSearchController < ApplicationController
  def index
    @items = Item.search_all_by_name(params[:name])
    if @item == []
      payload = {
                  data: {},
                  error: 'null'
                }
    render :json => payload, :status => 200
    else
      render json: ItemSerializer.new(@items)
    end
  end
end
