class AddScaleToMetrics < ActiveRecord::Migration[5.1]
  def change
    add_column :metrics, :scale, :string
  end
end
