class RoomsController < ApplicationController
  before_action :set_room, only: [:edit, :update, :show, :destroy, :download]
  before_action :authenticate_user!
  before_action :check_download_permission, only: :download

  def index
  end

  def new
    @room = current_user.host_rooms.build
    if params[:from_group_show_page]
      @room.group_id = params[:room][:group_id]
    end
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      invite_group_members_to_room
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

  def download
    respond_to do |format|
      # format.html
      format.pdf do
        render pdf: "pdf_download_#{@room.name}",
               encording: 'UTF-8',
               layout: 'layouts/pdf.html.slim',
               template: "posts/_index.html.slim",
               header: {
                          center: "#{@room.name}\n#{@room.description}"}
      end
    end
  end

  private
  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :description, :group_id, :distinguish_speaker,
                                 :let_guests_view_all, :show_member_list, :host_id, :from_group_show_page)
  end

  def find_group
    @group = Group.find(params[:room][:group_id])
  end

  def invite_group_members_to_room
    if params[:from_group_show_page]
      find_group
      @group.group_members.each do |member|
        @room.invite_chat_member(member)
      end
    else
      @room.invite_chat_member(@room.host)
    end
  end

  def check_download_permission
    unless @room.let_guests_view_all_true? || ( current_user == @room.host)
      redirect_to @room, notice: "権限がありません"
    end
  end
end
