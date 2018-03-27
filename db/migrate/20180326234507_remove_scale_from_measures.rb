class RemoveScaleFromMeasures < ActiveRecord::Migration[5.1]
  def change
    remove_column :measures, :scale, :string
  end
end
