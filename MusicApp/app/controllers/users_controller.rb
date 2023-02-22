

class UsersController < ApplicationController
    
    before_action :require_logged_in, only: [:index, :edit, :update, :show, :destroy]
    before_action :require_logged_out, only: [:new, :create]
    
    def index
        @users = User.all
        
        render :index
    end
    
    def edit
        @user = User.find(params[:id])
        
        render :edit
    end
    
    def update
        @user = User.find(params[:id])
        
        if @user.update(user_params)
            redirect_to user_url(@user)
        else
            puts @user.errors.full_messages # will print errors on server log
            render :edit
        end
    end
    
    
    def show
        @user = User.find(params[:id])
        
        render :show
    end
    
    
    
    def destroy
        user = User.find(params[:id])
        user.destroy
        redirect_to users_url
    end
    
    def new
        @user = User.new
        
        render :new
    end
    
    def create
        @user = User.new(user_params)
        
        if @user.save
            login(@user)
            redirect_to user_url(@user)
        else
            puts @user.errors.full_messages # will print errors on server log
            render :new
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :age, :password)
    end
end




























