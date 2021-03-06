class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user, only: [:edit, :update]
    def new
        @user = User.new
    end

    def index
        @users = User.all
    end

    def edit
        @user = User.find(params[:id])
    end

    def show 
        @user = User.find(params[:id])
    end

    def create
        @user = User.new(user_params)
        if @user.save
            @user.send_activation_email
            UserMailer.account_activation(@user).deliver_now
            flash[:info] = "Please check your email to activate your account."
            redirect_to root_url
        else
            flash[:error] = "Le formulaire contient des erreurs!"
            render 'new'
            
        end
    end


    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
        unless logged_in?
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
    end

    #Confirms the correct user
    def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless @user == current_user
    end
end