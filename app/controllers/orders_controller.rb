class OrdersController < ApplicationController
  before_action :require_signin
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    if params[:search]
      # @orders = Order.search(params[:search])
      @orders = Order.active.status(params[:status]).search(params[:search]).paginate(page: params[:page], per_page: 10).order('id ASC')
    else
      # @orders = Order.all
      @orders = Order.active.status(params[:status]).paginate(page: params[:page], per_page: 10).order('id ASC')
    end
  end

  def archief
    if params[:search]
      # @orders = Order.search(params[:search])
      @orders = Order.archive.status(params[:status]).search(params[:search]).paginate(page: params[:page], per_page: 10).order('id ASC')
    else
      # @orders = Order.all
      @orders = Order.archive.status(params[:status]).paginate(page: params[:page], per_page: 10).order('id ASC')
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @items = @order.items.build
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order is succesvol aangemaakt.' }
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
        format.html { redirect_to @order, notice: 'Order is succesvol geupdate.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order is succesvol verwijderd.' }
      format.json { head :no_content }
    end
  end

    def next_status
  @order = Order.find(params[:id])
  case @order.status
  when @order.status = "nieuw"
    @order.status = "prepress"
    @order.save
    redirect_to orders_url(:status => params[:status], :search => params[:search]), notice: 'Order is succesvol geupdate.'
  when @order.status = "prepress"
    @order.status = "print"
    @order.save
    redirect_to orders_url(:status => params[:status], :search => params[:search]), notice: 'Order is succesvol geupdate.'
  when @order.status = "print"
    @order.status = "nabewerking"
    @order.save
    redirect_to orders_url(:status => params[:status], :search => params[:search]), notice: 'Order is succesvol geupdate.'
  when @order.status = "nabewerking"
    @order.status = "Verpakken"
    @order.save
    redirect_to orders_url(:status => params[:status], :search => params[:search]), notice: 'Order is succesvol geupdate.'
  else
    @order.status = "gereed"
    @order.save
    redirect_to orders_url(:status => params[:status], :search => params[:search]), notice: 'Order is succesvol geupdate.'
    end
  end

    def prev_status
  @order = Order.find(params[:id])
  case @order.status
  when @order.status = "gereed"
    @order.status = "verpakken"
    @order.save
    redirect_to orders_url(:status => params[:status], :search => params[:search]), notice: 'Order is succesvol geupdate.'
  when @order.status = "verpakken"
    @order.status = "nabewerking"
    @order.save
    redirect_to orders_url(:status => params[:status], :search => params[:search]), notice: 'Order is succesvol geupdate.'
  when @order.status = "nabewerking"
    @order.status = "print"
    @order.save
    redirect_to orders_url(:status => params[:status], :search => params[:search]), notice: 'Order is succesvol geupdate.'
  when @order.status = "print"
    @order.status = "prepress"
    @order.save
    redirect_to orders_url(:status => params[:status], :search => params[:search]), notice: 'Order is succesvol geupdate.'
  else
    @order.status = "nieuw"
    @order.save
    redirect_to orders_url(:status => params[:status], :search => params[:search]), notice: 'Order is succesvol geupdate.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:customer, :order_number, :despatch_date, :status, :comments,
        items_attributes: [:id, :article_description])
    end
end
