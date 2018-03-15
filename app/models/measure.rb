class Measure < ApplicationRecord
	belongs_to :unit_of_measurement
	belongs_to :final_measure
	acts_as_list
end
