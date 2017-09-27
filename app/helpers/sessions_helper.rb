module SessionsHelper






	# logs in the given user

	def log_in(user)
		session[:user_id]=user.id
		#session[:user_id]= User.last.id
		end

#Return  the current logged-in user (if any )
		def current_user
if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
         # The tests still pass, so this branch is currently untested.
      user = User.find_by(id: user_id)
    # if user && user.authenticated?(cookies[:remember_token])     # it checks whether token stored in cookies is same as token in cookies--
       #if user && user.authenticated?(:remember, cookies[:remember_token])  # remember - as 2arguments has to specified based  on the method
        if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
		end


		def logged_in?
			!current_user.nil?     #returns true if the user is logged-in
		end


def signed_in?
    !!current_user
  end

  def is_admin?
    signed_in? ? current_user.admin : false
  end


# Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
end

		def log_out
forget(current_user)
    session.delete(:user_id)
    @current_user = nil
		end


		def remember(user)
      user.remember
      cookies.permanent.signed[:user_id] = user.id
      cookies.permanent[:remember_token]=user.remember_token
		end
def redirect_back_or(default)
  redirect_to(session[:requested_url] || default)
session.delete(:requested_url)
end


def store_location

session[:requested_url]=request.original_url if request.get?

end




end
