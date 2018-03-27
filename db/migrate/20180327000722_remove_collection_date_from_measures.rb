class RemoveCollectionDateFromMeasures < ActiveRecord::Migration[5.1]
  def change
    remove_column :measures, :collection_date, :date
  end
end
