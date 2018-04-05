class AddCollectDateToFinalMeasures < ActiveRecord::Migration[5.1]
  def change
    add_column :final_measures, :collect_date, :date
  end
end
