class AddReadToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :read, :boolean, default: false
  end
end
