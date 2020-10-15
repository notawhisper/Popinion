class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def show
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
