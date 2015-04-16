class TypesController < ApplicationController
  before_action :require_user#, except: [:show]
  
  def show
    @type = Type.find(params[:id])
    @staffs = @type.staffs.paginate(page: params[:page], per_page: 20)
  end
  
  def new
    @type = Type.new
  end
  
  def create
    @type = Type.new(type_params)
    if @type.save
      flash[:success] = "The new staff department was created successfully."
      redirect_to staffs_path
    else
      render 'new'
    end
  end
  
  private
    
    # Whitelisting allowed parameters
    def type_params
      params.require(:type).permit(:department)
    end
  
end