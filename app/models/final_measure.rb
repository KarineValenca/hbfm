class FinalMeasure < ApplicationRecord
	has_many :measures, dependent: :destroy
	belongs_to :metric

	require 'csv'

	def self.import(file, metric)
		CSV.foreach(file.path, headers: true) do |row|
			record = FinalMeasure.where(
       			:metric_id => metric,
       			:collect_date => DateTime.strptime(row[0], "%d/%m/%Y").strftime("%Y/%m/%d"),
       			:value => row[1],
       			:is_final => true
		    ).create
		    Measure.create!(:name => row[2], :value=>row[1],:collect_date => row[0],
		    	:final_measure_id => record.id, :operator => '+')
		end
	end
end
