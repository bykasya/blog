class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found

  def index
   @orders=Order.all
  end

  def show
    #@customer=Customer.find(params[:customer_id])
  end

  def new
    @order=Order.new
  end

 def create
   @order=Order.new(order_params)
    if @order.save
    flash.notice = "The order record was created successfully."
    redirect_to @order
  else
    flash.now.alert = @order.errors.full_messages.to_sentence
    render :new
  end
 end

 def edit
 end

 def update
   @order.update(order_params)
   redirect_to @order
 end

 def destroy
   @order.destroy
   redirect_to orders_path
 end

 private

   def order_params
     order_params=params.require(:order).permit(:product_name, :product_count, :customer_id)
   end

   def set_order
     @order=Order.find(params[:id])
   end
end
