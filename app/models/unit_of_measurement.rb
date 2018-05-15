class UnitOfMeasurement < ApplicationRecord
	has_many :metrics
	belongs_to :user

	validates :name, presence: true
	validates :initials, presence: true
end
