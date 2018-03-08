class Measure < ApplicationRecord
	belongs_to :unit_of_measurement
	belongs_to :metric
	acts_as_list
end
