class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    if current_user.user_type == 1
      @users = User.all
    else
      @users = current_user
    end
  end

  def edit
  end

  def new
  end

  def show
  end

  def create
  end

  def update
    respond_to do |format|
      if  @user.update(user_params)
        format.html {redirect_to @user, notice: 'User was successfully updated.'}
        format.json {render :edit, status: :ok, location: @user}
      else
        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.user_type == 1
        format.html {redirect_to users_url, notice: 'Admin account cannot be deleted'}
        format.json {head :no_content}
      else
        @user.destroy
        format.html {redirect_to users_url, notice: 'User was successfully destroyed.'}
        format.json {head :no_content}
      end
    end
  end
  def set_user
    if(params[:id] != 'sign_out')
      @user = User.find(params[:id])
    end
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :password, :email, :user_type)
  end
end
