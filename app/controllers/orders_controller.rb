class OrdersController < ApplicationController
  load_resource only: [:index, :show, :edit, :update, :destroy]
  authorize_resource
  # skip_load_resource only: [] 
  # before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    # if Customer 
      # @orders = current_user.recent_orders
    # elsif Manager || Admin 
      # @orders = Order.all
    # end
    # @orders = current_user.orders_by_status
    
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order_items = @order.order_items
  end

  # # GET /orders/new
  # def new
  #   @order = Order.new
  # end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /orders/1
  # # DELETE /orders/1.json
  # def destroy
  #   @order.destroy
  #   respond_to do |format|
  #     format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  
  def show_cart
    @order = get_or_create_order_from_session
    @order_items = @order.order_items
    render "cart"
  end
  
  def add_to_cart
    # byebug
    id = params[:id]
    quantity = params[:quantity].to_i
    cart = get_or_create_order_from_session
    cart.add_item(id, quantity)
    cart.save
    redirect_to cart_url
  end
  
  def clear_cart
    begin
      cart = Order.find(session[:order_id])
      cart.destroy
      # cart.cancel!
    ensure
      session[:order_id] = nil
      respond_to do |format|
        format.html { redirect_to books_url, notice: 'Cart is now empty.' }
        format.json { head :no_content }
      end
    end
  end
  
  def checkout
    @steps = ['address', 'delivery', 'payment', 'confirm', 'complete']
    @user = current_user
    @order = get_or_create_order_from_session
    render 'orders/checkout/checkout'
  end
  
  def place
    if @order.may_process?
      @order.process
    else
      respond_to do |format|
        format.html { redirect_to @order, notice: "Order can't be processed. Contact with support." }
      end
    end
    redirect_to orders_path
  end
      
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end
    
    def get_or_create_order_from_session
      begin
        order = Order.find(session[:order_id])
      rescue ActiveRecord::RecordNotFound
        params = {shipping_address: '_', billing_address: '_'}
        params.merge({ user: current_user }) if user_signed_in?
        order = Order.create(params)
        session[:order_id] = order.id
      end
      order
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:state, :completed_date, :total_price, :user_id, :credit_card_id, :shipping_address, :billing_address)
    end
end
