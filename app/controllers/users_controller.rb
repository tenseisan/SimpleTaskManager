# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_current_user
  before_action :authenticate_user!

  def show
    @user = User.find_by(id: params[:id]) || current_user
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Successfully updated'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def set_current_user
    @user = current_user
  end
end
