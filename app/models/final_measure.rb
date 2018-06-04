class FinalMeasure < ApplicationRecord
	has_many :measures, dependent: :destroy
	belongs_to :metric

	require 'csv'

	def self.import(file, metric)
		CSV.foreach(file.path, headers: true) do |row|
			record = FinalMeasure.where(
       			:metric_id => metric,
       			:collect_date => row[0],
       			:value => row[1],
       			:is_final => true
		    ).create
		end
	end
end
