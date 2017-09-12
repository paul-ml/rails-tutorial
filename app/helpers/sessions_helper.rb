module SessionsHelper






	# logs in the given user

	def log_in(user)
		session[:user_id]=user.id
		#session[:user_id]= User.last.id
		end

#Return  the current logged-in user (if any )
		def current_user

		 @current_user ||= User.find_by(id: session[:user_id])
		end


		def logged_in?
			!current_user.nil?     #returns true if the user is logged-in
		end


		def logout
session.delete(:user_id)
@current_user =nil
		end
end
