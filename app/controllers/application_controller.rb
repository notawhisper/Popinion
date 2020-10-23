class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    user_path(id: current_user.id)
  end

  def reject_request_from_guest
    if @room && (current_user != @room.host)
      redirect_to @room, notice: "権限がありません"
    elsif @group && (current_user != @group.owner)
      redirect_to @group, notice: "権限がありません"
    end
  end
end
