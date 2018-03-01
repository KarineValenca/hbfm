class MeasuresController < ApplicationController
	before_action :set_measure, only: [:show, :edit, :update, :destroy]

	def index
		@measures = Measure.all
	end

	def new
		@metric = Metric.find(params[:metric])
		@measure = Measure.new
		@last_measure = Measure.last
	end

	def create
		@measure = Measure.new(measure_params)

		respond_to do |format|
      		if @measure.save
        		format.html { redirect_to @measure, notice: 'Medida Criada com Sucesso.' }
        		format.json { render :show, status: :created, location: @measure}
      		else
		        format.html { render :new }
		        format.json { render json: @measure.errors, status: :unprocessable_entity }
      		end
		end
	end

	def show

	end

	private
    def set_measure
      @measure = Measure.find(params[:id])
    end

    def measure_params
      params.require(:measure).permit(:name, :value, :collection_date, :scale, :unit_of_measurement_id,
      									:metric_id)
	end
end