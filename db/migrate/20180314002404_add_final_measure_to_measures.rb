class AddFinalMeasureToMeasures < ActiveRecord::Migration[5.1]
  def change
    add_reference :measures, :final_measure, foreign_key: true
  end
end
