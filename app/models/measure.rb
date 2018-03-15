class Measure < ApplicationRecord
	belongs_to :unit_of_measurement
	belongs_to :final_measure
	acts_as_list

	before_save :set_position

	protected

	def set_position
		self.position ||= 1 + (Measure.where('final_measure_id=?',FinalMeasure.last.id).maximum(:position) || 0)
	end
end
