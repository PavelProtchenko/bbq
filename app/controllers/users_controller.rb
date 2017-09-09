class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_current_user, except: [:show]

  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      redirect_to @user, notice: I18n.t('User was successfully updated')
    else
      render :edit
    end
  end

  private

    def set_current_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email :avatar)
    end
end
