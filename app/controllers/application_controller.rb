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
    unless current_user.nil?

      notif_owner = []
      current_user.animals.each do |animal|
        notif_owner << animal.bookings.where(status: "pending")
        #notif_owner = true if !animal.bookings.where(status: "pending").to_a.blank?
      end
      flash[:notice] = "Hey, #{current_user.first_name}. You have pending approval. Let's have a look on your #{view_context.link_to 'your profil', profil_path(current_user)} ;)".html_safe if notif_owner.flatten.any?

      notif_user = current_user.bookings.where(status: "accept", read: false).each do |notif|
        notif.read = true
        notif.save!
      end
      flash[:notice] = "Congrats, #{current_user.first_name}. One of your Booking have been Approved. Let's have a look on your #{view_context.link_to 'your profil', profil_path(current_user)} ;)".html_safe if notif_user.any?
    end
    # raise
  end
end
