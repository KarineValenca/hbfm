class CreateMeasures < ActiveRecord::Migration[5.1]
  def change
    create_table :measures do |t|
      t.string :name
      t.float :value
      t.date :collection_date
      t.string :scale

      t.timestamps
    end
  end
end
