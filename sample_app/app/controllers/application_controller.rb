class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def Hello
  	render html:"Hello World !"
  	end
end
