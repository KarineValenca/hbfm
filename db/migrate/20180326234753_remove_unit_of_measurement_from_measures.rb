class RemoveUnitOfMeasurementFromMeasures < ActiveRecord::Migration[5.1]
  def change
    remove_reference :measures, :unit_of_measurement, foreign_key: true
  end
end
