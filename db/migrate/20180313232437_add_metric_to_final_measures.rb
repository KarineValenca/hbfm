class AddMetricToFinalMeasures < ActiveRecord::Migration[5.1]
  def change
    add_reference :final_measures, :metric, foreign_key: true
  end
end
