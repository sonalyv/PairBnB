class AddConfirmedToReservations < ActiveRecord::Migration[5.2]
  def change
    add_column :reservations, :confirmed, :boolean
  end
end
