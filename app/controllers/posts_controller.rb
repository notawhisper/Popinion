class PostsController < ApplicationController
  before_action :authenticate_user!
  def create
    @room = Room.find(params[:room_id])
    @post = current_user.posts.build(post_params)
    @post.room_id = @room.id
    if @post.save
      redirect_to room_path(@room.id)
    else
      render "rooms/show"
    end
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end
end
