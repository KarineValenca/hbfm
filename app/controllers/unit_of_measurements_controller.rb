class UnitOfMeasurementsController < ApplicationController
	before_action :set_unit_of_measurement, only: [:show, :edit, :update, :destroy]

	def index
   		@unit_of_measurements = UnitOfMeasurement.all
	end

	def new
		@unit_of_measurement = UnitOfMeasurement.new
	end

	def create
		@unit_of_measurement = UnitOfMeasurement.new(unit_of_measurement_params)

		respond_to do |format|
      		if @unit_of_measurement.save
        		format.html { redirect_to @unit_of_measurement, notice: 'Unidade de Medida Criada com Sucesso.' }
        		format.json { render :show, status: :created, location: @unit_of_measurement }
      		else
		        format.html { render :new }
		        format.json { render json: @unit_of_measurement.errors, status: :unprocessable_entity }
      		end
		end
	end

	def show
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit_of_measurement
      @unit_of_measurement = UnitOfMeasurement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_of_measurement_params
      params.require(:unit_of_measurement).permit(:name, :initials)
	end
end
