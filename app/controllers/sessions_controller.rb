class SessionsController < ApplicationController
  def new
  end

  def create

  	user=User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		#redirect to users page
  		log_in user
  		redirect_to user
  	else
  		flash[:danger]= 'Invalid username/password'

  	render 'new'
  end


end

  def destroy
  	end


end
