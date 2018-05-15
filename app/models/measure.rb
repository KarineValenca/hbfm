class Measure < ApplicationRecord
	belongs_to :final_measure

	validates :value, presence: true
	validates :name, presence: true
	validates :collect_date, presence: true
	before_save :set_position

	protected

	def set_position
		self.position ||= 1 + (Measure.where(:final_measure_id => FinalMeasure.last).maximum(:position) || 0)
	end
end
