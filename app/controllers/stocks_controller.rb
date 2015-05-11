class StocksController < ApplicationController
  before_action :set_stock, only: [:edit, :update, :show]
  before_action :require_user
  before_action :admin_user, only: [:destroy, :edit, :update, :show, :index]
  
  def index
    @stocks = Stock.all
    @sent_stocks = SentStock.all
  end
  
  def show
    
  end
  
  def new
    @stock = Stock.new
  end
  
  def create
    @stock = Stock.new(stock_params)
    @stock.staff = current_user
    if @stock.save
      flash[:success] = "Your items have been added to the stock inventory successfully."
      redirect_to stock_path(@stock)
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    @stock.staff = current_user
    if @stock.update(stock_params)
      flash[:success] = "The stock inventory have been updated successfully."
      if logged_in?
        redirect_to stock_path(@stock)
      else
        redirect_to home
      end
    else
      render 'new'
    end
  end
  
  def destroy
    Stock.find(params[:id]).destroy
    flash[:success] = "The inventory item has been successfully deleted"
    redirect_to stocks_path
  end
  
  def stockoutput
    @stocks = Stock.order(id: :desc)
    @sent_stocks = SentStock.order(id: :desc)
    respond_to do |format|
      format.html
      format.csv do
        #send_data @computers.to_csv
        headers['Content-Disposition'] = "attachment; filename=\"#{DateTime.now.to_date.to_s + "_stock.csv"}\""
        headers['Content-Type'] ||= 'text/csv'
      end
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"#{DateTime.now.to_date.to_s + "_stock.xls"}\"" } 
      #{ send_data @computers.to_csv(col_sep: "\t") }
    end
  end
  
  private
  
  def set_stock
    @stock = Stock.find(params[:id])
  end
  
  def stock_params
    params.require(:stock).permit(:keyboards, :mice, :monitors, :printers, :speakers)
  end
  
end