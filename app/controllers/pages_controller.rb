class PagesController < ApplicationController
  
  def home
    # Used to redirect logged in users to the computer index from home
    # redirect_to computers_path if logged_in?
  end
  
end