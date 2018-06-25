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
		puts "OLA"
		option = [params[:param]]
		puts "#{search}"
	end

	private
    def set_metric
      @metric = Metric.find(params[:id])
    end

    def metric_params
      params.require(:metric).permit(:name, :scale, :unit_of_measurement_id, :user_id)
	end

end
