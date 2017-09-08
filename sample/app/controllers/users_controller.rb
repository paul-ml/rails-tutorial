class UsersController < ApplicationController
 
  def new

  	@user=Userr.new
  end

  def show

@user= Userr.find(params[:id])

  end

end
