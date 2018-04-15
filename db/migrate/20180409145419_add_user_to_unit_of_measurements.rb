class AddUserToUnitOfMeasurements < ActiveRecord::Migration[5.1]
  def change
    add_reference :unit_of_measurements, :user, foreign_key: true
  end
end
