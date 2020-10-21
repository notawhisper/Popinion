class GroupMembersController < ApplicationController
  before_action :user_exist?, only: [:create]
  before_action :find_group
  before_action :reject_request_from_guest
  before_action :is_target_user_already_member?, only: [:create]

  def create
    target_user = User.find_by(email: params[:email])
    if @group.invite_group_member(target_user)
      redirect_to @group
    else
      render template: "groups/show", notice: "無効なアドレスです"
    end
  end

  def destroy
    target_user = User.find(params[:id])
    @group.group_memberships.find_by(user_id: target_user.id).destroy
    redirect_to @group
  end

  private
  def find_group
    @group = Group.find(params[:group_id])
  end

  def user_exist?
    unless User.exists?(email: params[:email])
      redirect_to @group, notice: "ユーザーが見つかりません"
    end
  end

  def is_target_user_already_member?
    if @group.group_members.exists?(email: params[:email])
      redirect_to @group, notice: "すでにメンバーです"
    end
  end
end