class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @my_groups = current_user.groups
  end

  def new
    @group = current_user.own_groups.build
  end

  def create
    group = Group.new(group_params)
    if group.save
      group.invite_group_member(group.owner)
      redirect_to group
    else
      render 'groups/new'
    end
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def group_params
    params.require(:group).permit(:name, :description, :owner_id)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
