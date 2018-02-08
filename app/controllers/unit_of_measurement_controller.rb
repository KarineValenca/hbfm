class UnitOfMeasurementController < ApplicationController

	def new

	end

	def create
		@unit_of_measurement = UnitOfMeasurement.new
	end
end
