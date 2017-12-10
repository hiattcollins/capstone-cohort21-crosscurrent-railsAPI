class UsersController < ApplicationController

# index, show, new, edit, create, update and destroy

  def index
    @users = User.all
    render json: @users
  end

  def show
    set_user
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, staus: :unprocessable_entity
    end
  end

  def update
    set_user
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end

end
