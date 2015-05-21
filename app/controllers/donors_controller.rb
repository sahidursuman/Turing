class DonorsController < ApplicationController
  before_action :set_donor, only: [:edit, :update, :show]
  before_action :require_user, except: [:existingdonor, :expiredonor]
  before_action :admin_user, only: [:destroy, :edit, :update, :show, :index]
  
  layout 'layouts/existingdonor', only: :existingdonor
  
  def index
    @donors = Donor.all
  end
  
  def show
    @computers = @donor.computers.paginate(page: params[:page], per_page: 20)
  end
  
  def new
    @donor = Donor.new
  end
  
  def create
    @donor = Donor.new(donor_params)
    if @donor.save
      flash[:success] = "Your details have been saved successfully"
      if logged_in?
        redirect_to donor_path(@donor)
      else 
        redirect_to thankyou_path
      end
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @donor.update(donor_params)
      flash[:success] = "Your details have been updated successfully"
      redirect_to donor_path(@donor)
    else
      render 'new'
    end
  end
  
  def destroy
    Donor.find(params[:id]).destroy
    flash[:success] = "The donor's details have been successfully deleted"
    redirect_to donors_path
  end
  
  def mailinglist
    @donors = Donor.all
  end
  
  def existingdonor
    # Find Exisiting Donor
    if params[:search]
      @donor = Donor.search(params[:search]).first
    end
    # Create Donor Session
    if @donor
     session[:current_donor] = @donor.id
     #flash[:current_donor] = @donor.id
    end
  end
  
  def expiredonor
    session.delete(:current_donor)
    redirect_to new_computer_path
  end

  private
  
    def set_donor
      @donor = Donor.find(params[:id])
    end
    
    # Whitelisting variables
    def donor_params
      params.require(:donor).permit(:donor_name, :donor_email, :allow_mail,
                                    :donor_address, :paper_cert)
    end
  
end