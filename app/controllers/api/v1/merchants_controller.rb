class Api::V1::MerchantsController < ApplicationController
  RESULTS_PER_PAGE = 20
  
  def index
    if params[:page]
      page_num = params[:page].to_i - 1
      merchants = Merchant.offset(page_num * RESULTS_PER_PAGE).limit(RESULTS_PER_PAGE)
      render json: MerchantSerializer.new(merchants)
    else 
      merchants = Merchant.limit(RESULTS_PER_PAGE)
      render json: MerchantSerializer.new(merchants)
    end 
  end

  def show 
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def find
    merchant = Merchant.where("lower(name) like ?", "%#{params[:name]}%".downcase).first
    render json: MerchantSerializer.new(merchant)
  end
end

