class CreateUnitOfMeasurements < ActiveRecord::Migration[5.1]
  def change
    create_table :unit_of_measurements do |t|
      t.string :name
      t.string :initials

      t.timestamps
    end
  end
end
