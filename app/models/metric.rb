class Metric < ApplicationRecord
	belongs_to :unit_of_measurement
	has_many :final_measures, dependent: :destroy
	belongs_to :user

	validates :name, presence: true
	validates :scale, presence: true
end
