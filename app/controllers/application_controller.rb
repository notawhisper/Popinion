class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :choose_layout

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def reject_request_from_guest
    if @room && (current_user != @room.host)
      redirect_to @room, alert: "権限がありません"
    elsif @group && (current_user != @group.owner)
      redirect_to @group, alert: "権限がありません"
    end
  end

  def choose_layout
    if devise_controller?
      "without_header"
    else
      "application"
    end
  end
end
