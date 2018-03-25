class CreateFinalMeasures < ActiveRecord::Migration[5.1]
  def change
    create_table :final_measures do |t|
      t.string :operation
      t.float :value

      t.timestamps
    end
  end
end
