class RemoveBookingDateFromBookings < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :booking_date, :string
  end
end
