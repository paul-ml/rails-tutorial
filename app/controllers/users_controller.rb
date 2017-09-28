class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit, :update, :destroy]     # this will be first action performed.
  # note order should be the same :update can come only after :edit 
  before_action :correct_user , only: [:edit , :update]
  before_action :admin_user, only: :destroy
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  
    def new
  	 @user=User.new
    end

    def index 

    #@users = User.paginate(page: params[:page])
    @users = User.where(activated: true).paginate(page: params[:page])

    end
    #checks whether user_emaild ="Pauljoegeorge@gmail.com" - if YES updated admin field with value TRUE
    #if values are successully store to dB --> send an activation email (token and email id included)
    def create
      @user=User.new(user_params)     #params[:user] - have entire details of user
     
      if @user.email=="pauljoegeorge@gmail.com"  
        @user.admin = true
      end
      if @user.save
        UserMailer.account_activation(@user).deliver_now
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_url
        #log_in @user        #  method log_in will be called 
        #Handle a successful save
        #flash[:success]="W e l c o m e T o P J D e s g i n s ! !"
        #redirect_to @user    
  	   else
  		  render 'new'
  	end
  end


    def edit
      @user=User.find(params[:id])
    end


    def show
      @user= User.find(params[:id])
      @microposts = @user.microposts.paginate(page: params[:page])  # for displaying the microposts for each user in teh display page 
      redirect_to root_url and return unless true
    end

    def update
        @user=User.find(params[:id])
          if @user.update_attributes(user_params)
            flash[:success] = "Profile updated"
            redirect_to @user
          else
            render 'edit'
          end
      end


    def destroy
      User.find(params[:id]).destroy
      flash[:success]="User deleted"
      redirect_to index_path
    end


    def logged_in_user
      unless  logged_in?
        store_location
        flash[:danger]="Please Login First"
        redirect_to login_path
      end
    end
   
    def correct_user

      @user=User.find(params[:id])
        unless @user==current_user
          flash[:danger]="You dont have enough privileges "
          redirect_to root_path
        end
    end

   def admin_user
      redirect_to root_path  unless current_user.admin?
    end

  

    def following
      @title = "Following"
      @user  = User.find(params[:id])
      @users = @user.following.paginate(page: params[:page])
      render 'show_follow'
    end

    def followers
      @title = "Followers"
      @user  = User.find(params[:id])
      @users = @user.followers.paginate(page: params[:page])
      render 'show_follow'
    end


    private

    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)  
     # this ensures that all the fields are filled.  (:name,:password  should be the same name as given in form(edit.html))
     end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
      
    end
  def current_user?(user)
    current_user = user
  end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end


end
