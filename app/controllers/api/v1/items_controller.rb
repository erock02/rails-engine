class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    @merchant = Merchant.find(params[:item][:merchant_id])
    render json: @merchant.items.create(item_params)
  end

  def update
    if Merchant.find_by(id: params[:item][:merchant_id]).nil?
      render status: 400
    else
      @item = Item.find(params[:id].to_i)
      @item.update(item_params)
      render json: ItemSerializer.new(@item)
    end
  end

  def destroy
    render json: Item.delete(params[:id])
  end

private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
