class SessionsController < ApplicationController
  def new
  end

  def create

      	user=User.find_by(email: params[:session][:email].downcase)
      	if user && user.authenticate(params[:session][:password])
      		#redirect to users page
           if user.activated?

        		 log_in user
             params[:session][:remember_me] == '1' ? remember(user) : forget(user)     
             #checking whether user checked checkobox or not? if checked remember(user) method else forget(user) method will be called

        		 redirect_back_or user

          else
         
            message = "Account not activated"
            message += "Please check your mail for further details"
            flash[:warning]= message
            redirect_to about_path
          end

      else
      		flash.now[:danger]= 'Invalid username/password'

      	  render 'new'
      end

  end

  def destroy

  	log_out if logged_in?
  	redirect_to root_url
  	end

end
