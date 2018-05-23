class UnitOfMeasurementsController < ApplicationController
	before_action :set_unit_of_measurement, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

	def index
   		@unit_of_measurements = UnitOfMeasurement.where(user_id: current_user.id)
	end

	def new
		@unit_of_measurement = UnitOfMeasurement.new
	end

	def create
		@unit_of_measurement = UnitOfMeasurement.new(unit_of_measurement_params)
		@unit_of_measurement.user_id = current_user.id

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
		
		if  @unit_of_measurement.user_id == current_user.id
			#nothing to do
		else
			respond_to do |format|
				format.html { redirect_to unit_of_measurements_path, notice: 'Você não pode acessar essa página' }
			end
		end
	end

	def edit
		@unit_of_measurement = UnitOfMeasurement.find(params[:id])
	end

	def update
		@unit_of_measurement = UnitOfMeasurement.find(params[:id])
		@unit_of_measurement.update_attributes(unit_of_measurement_params)
		respond_to do |format|
      		if @unit_of_measurement.save
        		format.html { redirect_to @unit_of_measurement, notice: 'Unidade de Medida Atualizada com Sucesso.' }
        		format.json { render :show, status: :created, location: @unit_of_measurement }
      		else
		        format.html { render :new }
		        format.json { render json: @unit_of_measurement.errors, status: :unprocessable_entity }
      		end
		end
	end

	def destroy
		@unit_of_measurement = UnitOfMeasurement.find(params[:id])
		@unit_of_measurement.destroy
		redirect_to @unit_of_measurement, notice: 'Unidade de Medida Excluída com Sucesso.'
	end

	private
    def set_unit_of_measurement
      @unit_of_measurement = UnitOfMeasurement.find(params[:id])
    end

    def unit_of_measurement_params
      params.require(:unit_of_measurement).permit(:name, :initials, :user_id)
	end
end
