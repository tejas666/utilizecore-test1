class SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:session][:email])
      
      if user&.authenticate(params[:session][:password])
        session[:user_id] = user.id
        set_current_user(user)
        redirect_to parcels_path, notice: 'Logged in successfully!'
      else

        flash.now[:alert] = 'Invalid username or password'
        render :new
      end
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path, notice: 'Logged out successfully!'
    end

    def new
        # Instantiate a new user object for the login form
        @user = User.new
    end
    

    def set_current_user(user)
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
      end
  
  end