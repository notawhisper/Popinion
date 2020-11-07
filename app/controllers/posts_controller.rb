class PostsController < ApplicationController
  before_action :authenticate_user!
  def create
    @room = Room.find(params[:room_id])
    @post = current_user.posts.build(post_params)
    @post.room_id = @room.id
    if @post.save
      broadcast(@post)
    end
    # if @post.save
    #   # redirect_to room_path(@room.id)
    #   render "rooms/show"
    # else
    #   render "rooms/show"
    # end
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end

  def broadcast(post)
    @room = Room.find(params[:room_id])
    code_number = current_user.current_code_number(post.room)
    ActionCable.server.broadcast "chat_room_#{@room.id}", message: post.content, date: post.created_at,
                                 code_number: code_number, let_guests_view_all: @room.let_guests_view_all,
                                 distinguish_speaker: @room.distinguish_speaker
  end
end
