class ComputersController < ApplicationController
  before_action :set_computer, only: [:edit, :update, :show, :thankyou, :drop_upload]
  before_action :require_user, except: [:new, :create, :thankyou]
  before_action :wipe_staff, except: [:new, :create, :thankyou, :show]
  before_action :admin_user, only: [:destroy, :dataoutput, :import, :import_page]

  layout :new_layout, only: [:new, :update, :thankyou]
  
  
  def index
    # Pagination of computers
    @computers = Computer.paginate(page: params[:page], per_page: 20)
  end
  
  def show
    @wipe = @computer.wipe
    @barcode = Barby::Code128B.new(@computer.turingtrack)
    @barcode_for_html = Barby::HtmlOutputter.new(@barcode)
    display # Dropbox Images
  end 
  
  def new
    @computer = Computer.new
    @computer.build_wipe
    @current_donor = Donor.find_by_id(session[:current_donor])
    if @current_donor
      @computer.donor = @current_donor
    else
      @computer.build_donor
    end
  end
  
  def create
    @computer = Computer.new(computer_params)
    # Set staff
    if logged_in?
      @computer.wipe.staff = current_user
    end
    # Set donor (if current_donor session is avaliable)
    current_donor = Donor.find_by_id(session[:current_donor])
    if current_donor
      @computer.donor = current_donor
    end
    # Upon submission of form
    if @computer.save
      flash[:success] = "You're computer's details have been submitted successfully!"
      DonorMailer.thankyou_email(@computer).deliver
      # Deals with different layouts and redirects for donors and staff
      if logged_in?
        redirect_to computers_path
      else
        redirect_to thankyou_computer_path(@computer)
      end
    else
      render :new, layout: new_layout
    end
  end
  
  def edit
    unless @computer.wipe
      @computer.build_wipe
    end
  end
  
  def update
    if @computer.wipe 
      @computer.wipe.staff = current_user
    else
      @computer.build_wipe
      @computer.wipe.staff = current_user
    end
    if @computer.update(computer_params)
      flash[:success] = "The computer's details have been updated successfully!"
      redirect_to computer_path(@computer)
    else
      render :edit
    end
  end
  
  def destroy
    Computer.find(params[:id]).destroy
    flash[:success] = "The computer's details have been successfully deleted."
    redirect_to computers_path
  end
  
  def table 
    #@computers = Computer.all
    if params[:search]
      @computers = Computer.search(params[:search]).order("created_at DESC").paginate(page: params[:page], per_page: 50)
    else
      @computers = Computer.all.order('created_at DESC').paginate(page: params[:page], per_page: 50)
    end
  end
  
  def thankyou
    @barcode = Barby::Code128B.new(@computer.turingtrack)
    @barcode_for_html = Barby::HtmlOutputter.new(@barcode)
  end
  
  def dataoutput
    @computers = Computer.order(id: :desc)
    respond_to do |format|
      format.html
      format.csv do
        #send_data @computers.to_csv
        headers['Content-Disposition'] = "attachment; filename=\"#{DateTime.now.to_date.to_s + "_computers.csv"}\""
        headers['Content-Type'] ||= 'text/csv'
      end
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"#{DateTime.now.to_date.to_s + "_computers.xls"}\"" } 
      #{ send_data @computers.to_csv(col_sep: "\t") }
    end
  end
  
  def import_page
    
  end
    
  def import
    # Stores as temp file on file system
    Computer.import(params[:file])
    redirect_to computertable_path
    flash[:success] = "Your backup database has been successfully imported!"
  end
  
  ##########################################################################################
  # Dropbox Image Uploader
  include Dropboxer
  
  def drop_upload
    upload
  end
  
  def drop_auth_start
    get_dropbox_client
    auth_start
  end
  
  def drop_auth_finish
    auth_finish
  end
  
  ##########################################################################################
  
  private
  
    # Whitelisting variables
    def computer_params
      params.require(:computer).permit(:manufacturer, :computer_type, :specification, 
                                       :model_no, :serial_no, :product_key, :hub_id,
                                       :turingtrack, :picture, wipe_attributes: 
                                       [:id, :action_taken, :staff_id, :operating_system_id],
                                       donor_attributes: [:id, :donor_name, 
                                       :donor_email, :allow_mail, :donor_address,
                                       :paper_cert])
    end
    
    def set_computer
      @computer = Computer.find(params[:id])
    end
    
    def new_layout
      if action_name == "thankyou"
        return "thankyou"
      else
        logged_in? ? "application" : "donate"
      end
    end
    
end