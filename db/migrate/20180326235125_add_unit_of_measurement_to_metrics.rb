class AddUnitOfMeasurementToMetrics < ActiveRecord::Migration[5.1]
  def change
    add_reference :metrics, :unit_of_measurement, foreign_key: true
  end
end
