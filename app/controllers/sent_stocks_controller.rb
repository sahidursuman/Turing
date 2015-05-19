class SentStocksController < ApplicationController
  before_action :set_sent_stock, only: [:edit, :update, :show]
  before_action :require_user
  before_action :admin_user, only: [:destroy, :edit, :update, :show, :index]
  
  def index
    @sent_stocks = SentStock.all
  end
  
  def show
    
  end
  
  def new
    @sent_stock = SentStock.new
  end
  
  def create
    @sent_stock = SentStock.new(sent_stock_params)
    @sent_stock.staff = current_user
    if @sent_stock.save
      flash[:success] = "Your items have been added to the stock inventory successfully."
      redirect_to sent_stock_path(@sent_stock)
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    @sent_stock.staff = current_user
    if @sent_stock.update(sent_stock_params)
      flash[:success] = "The stock inventory have been updated successfully."
      if logged_in?
        redirect_to sent_stock_path(@sent_stock)
      else
        redirect_to home
      end
    else
      render 'new'
    end
  end
  
  def destroy
    SentStock.find(params[:id]).destroy
    flash[:success] = "The inventory item has been successfully deleted"
    redirect_to sent_stocks_path
  end
  
  private
  
  def set_sent_stock
    @sent_stock = SentStock.find(params[:id])
  end
  
  def sent_stock_params
    params.require(:sent_stock).permit(:sent_batch_name, :sent_keyboards, :sent_mice, :sent_monitors, :sent_printers, :sent_speakers,
                                      :sent_vga_cables, :sent_kettle_leads, :sent_routers, :sent_lan_switches)
  end
  
end