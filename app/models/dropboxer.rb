 module Dropboxer
  
  require 'securerandom'

  def main
  
    client = get_dropbox_client
    unless client
      redirect_to(:action => 'auth_start') and return
    end
  
    account_info = client.account_info
  
    # Show a file upload page
    render :inline =>
      "#{account_info['email']} <br/><%= form_tag({:action => :upload}, :multipart => true) do %><%= file_field_tag 'file' %><%= submit_tag 'Upload' %><% end %>"
  end
  
  def upload
    client = get_dropbox_client
    @client = client
    unless client
      redirect_to(:action => 'auth_start') and return
    end
    begin
      # Upload the POST'd file to Dropbox, Naming it using the TuringTrack and original file extension
      resp = client.put_file("IMG_" + @computer.turingtrack + File.extname(params[:file].original_filename), params[:file].read)
      flash[:success] = "Your image has been successfully uploaded to Dropbox at #{resp['path']}"
      redirect_to :back
      #ender :text => "Upload successful.  File now at #{resp['path']}"
    rescue DropboxAuthError => e
      session.delete(:access_token)  # An auth error means the access token is probably bad
      logger.info "Dropbox Upload Authorisation error: #{e}"
      # render :text => "Dropbox auth error"
      flash[:danger] = "Dropbox Upload Authorisation Error: #{e}"
    rescue DropboxError => e
      logger.info "Dropbox Upload API error: #{e}"
      #render :text => "Dropbox API error"
      flash[:danger] = "Dropbox Upload API Error: #{e}"
    end
  end
  
  def display
    client = get_dropbox_client
    unless client
      redirect_to(:action => 'auth_start') and return
    end
    begin
      @photo_url = client.media("IMG_" + @computer.turingtrack + ".jpg")
      #render inline: 
        #client.metadata('/').inspect # List of all photos in folder
    rescue DropboxAuthError => e
      session.delete(:access_token)  # An auth error means the access token is probably bad
      logger.info "Dropbox Displau Authorisation error: #{e}"
      #render :text => "Dropbox auth error"
      flash[:danger] = "Dropbox Display Authorisation Error: #{e}"
    rescue DropboxError => e
      logger.info "Dropbox Display API error: #{e}"
      #render :text => "Dropbox API error"
      flash[:danger] = "Dropbox Display API Error: #{e}"
    end
  end
  
  def get_dropbox_client
    if session[:access_token]
      begin
        access_token = session[:access_token]
        DropboxClient.new(access_token)
      rescue
        # Maybe something's wrong with the access token?
        session.delete(:access_token)
        raise # Raises a RunTimeError, a subclass of StandardError
      end
    end
  end
  
  def get_web_auth()
    redirect_uri = url_for(:action => 'auth_finish')
    DropboxOAuth2Flow.new(DROPBOX_APP_KEY, DROPBOX_APP_SECRET, redirect_uri, session, :dropbox_auth_csrf_token)
  end
  
  def auth_start
    authorize_url = get_web_auth().start()
    # Send the user to the Dropbox website so they can authorize our app.  After the user
    # authorizes our app, Dropbox will redirect them here with a 'code' parameter.
      redirect_to authorize_url
  end
  
  def auth_finish
    begin
      access_token, user_id, url_state = get_web_auth.finish(params)
      session[:access_token] = access_token
      redirect_to :action => 'main'
    rescue DropboxOAuth2Flow::BadRequestError => e
      #render :text => "Error in OAuth 2 flow: Bad request: #{e}"
      flash[:danger] = "Error in OAuth 2 flow: Bad request: #{e}"
    rescue DropboxOAuth2Flow::BadStateError => e
      logger.info("Error in OAuth 2 flow: No CSRF token in session: #{e}")
      redirect_to(:action => 'auth_start')
    rescue DropboxOAuth2Flow::CsrfError => e
      logger.info("Error in OAuth 2 flow: CSRF mismatch: #{e}")
      #render :text => "CSRF error"
      flash[:danger] = "CSRF Error"
    rescue DropboxOAuth2Flow::NotApprovedError => e
      #render :text => "Approval Error: Session must be Authorised"
      flash[:danger] = "Approval Error: Session must be Authorised"
    rescue DropboxOAuth2Flow::ProviderError => e
      logger.info "Error in OAuth 2 flow: Error redirect from Dropbox: #{e}"
      #render :text => "Strange error."
      flash[:danger] = "Strage Error: #{e}"
    rescue DropboxError => e
      logger.info "Error getting OAuth 2 access token: #{e}"
      #ender :text => "Error communicating with Dropbox servers."
      flash[:danger] = "Error communicating with Dropbox servers."
    end
  end

end