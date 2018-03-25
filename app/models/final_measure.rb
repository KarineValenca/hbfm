class FinalMeasure < ApplicationRecord
	has_many :measures
	belongs_to :metric
end
