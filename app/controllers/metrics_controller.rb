class MetricsController < ApplicationController
	before_action :set_metric, only: [:show, :edit, :update, :destroy]

	def index
		@metrics = Metric.all
	end

	def new
		@metric = Metric.new
	end

	def create
		@metric = Metric.new(metric_params)

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

	def show
		@final_measures = FinalMeasure.where(:metric_id => @metric.id, :is_final => true)
	end

	private
    def set_metric
      @metric = Metric.find(params[:id])
    end

    def metric_params
      params.require(:metric).permit(:name, :scale, :unit_of_measurement_id)
	end

end
