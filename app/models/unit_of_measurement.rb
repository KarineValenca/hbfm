class UnitOfMeasurement < ApplicationRecord
	has_many :metrics
	belongs_to :user
end
