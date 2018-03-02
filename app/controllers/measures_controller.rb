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

		
      		if @measure.save
      			respond_to do |format|
    				format.html { redirect_to measures_url }
				    format.js
  				end
      		else
		        format.html { render :new }
		        format.json { render json: @measure.errors, status: :unprocessable_entity }
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