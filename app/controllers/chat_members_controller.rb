class ChatMembersController < ApplicationController
  before_action :user_exist?, only: [:create]
  before_action :is_target_user_already_member?, only: [:create]

  def create
    room = find_room(params[:room_id])
    target_user = User.find_by(email: params[:email])
    if room.invite_member(target_user)
      redirect_to room
    else
      render template: "rooms/show", notice: "無効なアドレスです"
    end
  end

  def destroy

  end

  private
  def find_room(id)
    Room.find(id)
  end

  def find_user_by(email:)
    User.find_by(email: email)
  end

  def user_exist?
    unless User.exists?(email: params[:email])
      redirect_to room_path(room), notice: "ユーザーが見つかりません"
    end
  end

  def is_target_user_already_member?
    room = Room.find(params[:room_id])
    if room.chat_members.exists?(email: params[:email])
      redirect_to room_path(room), notice: "すでにメンバーです"
    end
  end
end
