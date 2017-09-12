class UsersController < ApplicationController
  def new
  	@user=User.new
  end
  def show
  	@user= User.find(params[:id])
  end
def create

@user=User.new(user_params)     #params[:user] - have entire details of user
if @user.save
	log_in @user
#Handle a successful save
flash[:success]="W e l c o m e T o P J D e s g i n s ! !"
redirect_to @user
	else
		render 'new'
	end
end
private
 def user_params
 params.require(:user).permit(:name,:email,:password,:password_confirmation)

 end


end
