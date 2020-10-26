class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :reject_request_from_guest, only: [:edit, :update, :destroy]

  def index
    @my_groups = current_user.groups
  end

  def new
    @group = current_user.own_groups.build
  end

  def create
    @group = current_user.own_groups.build(group_params)
    if @group.save
      @group.invite_group_member(@group.owner)
      redirect_to @group, notice: t('.success')
    else
      render "new"
      # , alert: t('.failed')
    end
  end

  def show

  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: t('.success')
    else
      render :edit, alert: t('.failed')
    end
  end

  def destroy
    if @group.destroy
      redirect_to user_path(current_user), notice: t('.success')
    else
      redirect_to user_path(current_user), alert: t('.failed')
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, :description, :owner_id)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
