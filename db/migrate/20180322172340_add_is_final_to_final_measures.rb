class AddIsFinalToFinalMeasures < ActiveRecord::Migration[5.1]
  def change
    add_column :final_measures, :is_final, :boolean
  end
end
