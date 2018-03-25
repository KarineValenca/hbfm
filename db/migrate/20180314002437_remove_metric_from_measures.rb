class RemoveMetricFromMeasures < ActiveRecord::Migration[5.1]
  def change
    remove_reference :measures, :metric, foreign_key: true
  end
end
