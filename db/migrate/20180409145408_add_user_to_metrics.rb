class AddUserToMetrics < ActiveRecord::Migration[5.1]
  def change
    add_reference :metrics, :user, foreign_key: true
  end
end
