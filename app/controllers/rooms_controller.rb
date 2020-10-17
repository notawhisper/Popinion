class RoomsController < ApplicationController
  before_action :set_room, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!

  def index
  end

  def new
    @room = current_user.host_rooms.build
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to @room, notice: t('.success')
    else
      render :new, notice: t('.failed')
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: t('.success')
    else
      render :edit, notice: t('.failed')
    end
  end

  def show
  end

  def destroy
    if @room.destroy
      redirect_to rooms_path, notice: t('.success')
    end
  end

  private
  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :description, :group_id, :distinguish_speaker,
                                 :let_guests_view_all, :show_member_list, :host_id)
  end
end
