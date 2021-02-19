class Api::V1::RevenueMerchantController < ApplicationController
  
  def index
    merchants = Merchant.merch_by_desc_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end
end