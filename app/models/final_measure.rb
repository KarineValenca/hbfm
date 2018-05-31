class FinalMeasure < ApplicationRecord
	has_many :measures, dependent: :destroy
	belongs_to :metric
end
