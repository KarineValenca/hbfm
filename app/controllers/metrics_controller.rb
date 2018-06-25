class MetricsController < ApplicationController
	before_action :set_metric, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

	def index
		@metrics = Metric.where(user_id: current_user.id)
	end

	def new
		@unit_of_measurements = UnitOfMeasurement.where(user_id: current_user.id)
		puts "#{@unit_of_measurements.length}"
		if @unit_of_measurements.length > 0
			@metric = Metric.new
		else
			redirect_to new_unit_of_measurement_path, notice: 'Você precisa cadastrar pelo menos uma unidade de medida antes de cadastrar uma métrica'
		end
	end

	def create
		
			@metric = Metric.new(metric_params)
			@metric.user_id = current_user.id

			respond_to do |format|
	      		if @metric.save
	        		format.html { redirect_to @metric, notice: 'Métrica Criada com Sucesso.' }
	        		format.json { render :show, status: :created, location: @metric}
	      		else
			        format.html { render :new }
			        format.json { render json: @metric.errors, status: :unprocessable_entity }
	      		end
			end
		
	end

	def update
		@metric = Metric.find(params[:id])
		@metric.update_attributes(metric_params)
		respond_to do |format|
      		if @metric.save
        		format.html { redirect_to @metric, notice: 'Métrica Atualizada com Sucesso.' }
        		format.json { render :show, status: :created, location: @metric }
      		else
		        format.html { render :new }
		        format.json { render json: @metric.errors, status: :unprocessable_entity }
      		end
		end
	end

	def show
		if  @metric.user_id == current_user.id
			@final_measures = FinalMeasure.where(:metric_id => @metric.id, :is_final => true)
			@measures = Measure.where(:final_measure_id => @final_measures)
		else
			respond_to do |format|
				format.html { redirect_to metrics_path, notice: 'Você não pode acessar essa página' }
			end

		end
	end


	def destroy
		@metric = Metric.find(params[:id])
		@metric.destroy
		redirect_to @metric, notice: 'Métrica Excluída com Sucesso.'
	end

	def create_pre_defined_metric
		option = params[:param]

		if option == "1"
			@unit_of_measurement = UnitOfMeasurement.find_or_create_by(:name => "Linhas de Código") do |unit_of_measurement|
				unit_of_measurement.initials = "LOC"
				unit_of_measurement.user_id = current_user.id
			end
			@metric = Metric.create!(:name => "Linhas de Código", :scale => "Absoluta", 
				:unit_of_measurement_id => @unit_of_measurement.id, :user_id => current_user.id)
			redirect_to @metric, notice: 'Métrica Criada com Sucesso'
		elsif option == "2"
			@unit_of_measurement = UnitOfMeasurement.find_or_create_by(:name => "Linhas de Código por Hora") do |unit_of_measurement|
				unit_of_measurement.initials = "LOC/h"
				unit_of_measurement.user_id = current_user.id
			end
			@metric = Metric.create!(:name => "Produtividade", :scale => "Ratio", 
				:unit_of_measurement_id => @unit_of_measurement.id, :user_id => current_user.id)
			redirect_to @metric, notice: 'Métrica Criada com Sucesso'
		elsif option == "3"
			@unit_of_measurement = UnitOfMeasurement.find_or_create_by(:name => "Pontos Entregues") do |unit_of_measurement|
				unit_of_measurement.initials = "PE"
				unit_of_measurement.user_id = current_user.id
			end
			@metric = Metric.create!(:name => "Velocity", :scale => "Absoluta", 
				:unit_of_measurement_id => @unit_of_measurement.id, :user_id => current_user.id)
			redirect_to @metric, notice: 'Métrica Criada com Sucesso'
		else 
			#nothing todo
		end
	end

	private
    def set_metric
      @metric = Metric.find(params[:id])
    end

    def metric_params
      params.require(:metric).permit(:name, :scale, :unit_of_measurement_id, :user_id)
	end

end
