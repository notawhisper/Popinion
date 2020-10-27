class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:edit, :update, :show, :destroy, :download, :set_code_numbers]
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
      render 'new'
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: t('.success')
    else
      render :edit, alert: t('.failed')
    end
  end

  def show
    set_restricted_posts unless @room.let_guests_view_all_true?
  end

  def destroy
    if @room.destroy
      redirect_to user_path(current_user), notice: t('.success')
    else
      redirect_to @room,  alert: t('.failed')
    end
  end

  def download
    respond_to do |format|
      format.pdf do
        render pdf: "pdf_download_#{@room.name}",
               encording: 'UTF-8',
               layout: 'layouts/pdf.html.slim',
               template: "posts/_index.html.slim"
               # header: {
               #            center: "#{@room.name}\n#{@room.description}"}
      end
    end
  end

  def set_code_numbers
    unless @room.nullify_code_numbers
      render :show, alert: t('.failed')
    end

    if @room.assign_code_number
      redirect_to @room, notice: t('.success')
    else
      render :show, alert: t('.failed')
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
      redirect_to @room, alert: "権限がありません"
    end
  end

  def get_own_posts
    @room.posts.where(user: current_user)
  end

  def get_posts_by_host
    @room.posts.where(user: @room.host)
  end

  def only_posts_by_host?
    (get_posts_by_host.any? && get_own_posts.none?) ? true : false
  end

  def only_posts_by_myself?
    (get_posts_by_host.none? && get_own_posts.any?) ? true : false
  end

  def set_restricted_posts
    if only_posts_by_host?
      @restricted_posts = get_posts_by_host
    elsif only_posts_by_myself?
      @restricted_posts = get_own_posts
    else
      @restricted_posts = [get_posts_by_host, get_own_posts].flatten
    end
  end
end
