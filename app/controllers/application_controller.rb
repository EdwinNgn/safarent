class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :booking_notifications

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :description, :photo])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :description, :photo])
  end

  def booking_notifications
    notif_owner = current_user.bookings.where(status: "pending", read: false)
    flash[:notice] = "Hey, #{current_user.first_name}. You have pending approval. Let's have a look on your profil ;)" if notif_owner.any?
    notif_user = current_user.bookings.where(status: "accept", read: false)
    flash[:notice] = "Congrats, #{current_user.first_name}. One of your Booking have been Approved. Let's have a look on your profil ;)" if notif_user.any?
  end
end
