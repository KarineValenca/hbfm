class Metric < ApplicationRecord
	belongs_to :unit_of_measurement
	has_many :final_measures
end
