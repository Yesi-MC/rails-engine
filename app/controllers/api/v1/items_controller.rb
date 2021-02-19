class Api::V1::ItemsController < ApplicationController
RESULTS_PER_PAGE = 20

  def index
    if params[:page] 
      page_num = params[:page].to_i - 1
      items = Item.offset(page_num * RESULTS_PER_PAGE).limit(RESULTS_PER_PAGE)
      render json: ItemSerializer.new(items)
    else 
      items = Item.limit(RESULTS_PER_PAGE)
      render json: ItemSerializer.new(items)
    end 
  end

  def show 
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create 
    render json: ItemSerializer.new(Item.create(item_params)), status: 201    
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  def find_all 
    items = Item.where("lower(name) like ?", "%#{params[:name]}%".downcase)
    render json: ItemSerializer.new(items)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end 