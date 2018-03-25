class AddMetricToMeasures < ActiveRecord::Migration[5.1]
  def change
    add_column :measures, :metric, :integer
  end
end
