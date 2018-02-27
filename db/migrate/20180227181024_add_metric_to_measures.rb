class AddMetricToMeasures < ActiveRecord::Migration[5.1]
  def change
    add_reference :measures, :metric, foreign_key: true
  end
end
