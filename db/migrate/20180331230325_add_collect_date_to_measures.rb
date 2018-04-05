class AddCollectDateToMeasures < ActiveRecord::Migration[5.1]
  def change
    add_column :measures, :collect_date, :date
  end
end
