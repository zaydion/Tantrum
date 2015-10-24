class UsersController < ApplicationController

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
      flash[:notice] = "Welcome to Tantrum!"
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user.destroy
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
