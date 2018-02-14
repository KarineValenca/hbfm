class AddUnitOfMeasurementToMeasures < ActiveRecord::Migration[5.1]
  def change
    add_reference :measures, :unit_of_measurement, foreign_key: true
  end
end
