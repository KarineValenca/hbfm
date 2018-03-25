class AddPositionToMeasures < ActiveRecord::Migration[5.1]
  def change
    add_column :measures, :position, :integer
  end
end
