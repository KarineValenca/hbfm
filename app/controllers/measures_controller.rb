class MeasuresController < ApplicationController
	before_action :set_measure, only: [:show, :edit, :update, :destroy]

	def index
		 @measures = Measure.order(:position)
	end

	def list
		@measures = Measure.order(:position)
	end

	def new
		@metric = Metric.find(params[:metric])
		@measure = Measure.new
		@last_measure = Measure.last
	end

	def create
		@measure = Measure.new(measure_params)
		@measures_list = []
		print '*' * 90
		if @measures_list.empty?
			@measure.position = 1
		else
			@measure.position = Measure.last.position + 1
		end
		
      		if @measure.save
      			respond_to do |format|
    				format.html { redirect_to measures_url }
				    format.js
  				end
  				
  				@measures_list << @measure
      		else
		        format.html { render :new }
		        format.json { render json: @measure.errors, status: :unprocessable_entity }
      		end

      	
	end

	def show

	end

	def sort
		params[:measure].each_with_index do |id, index|
   			Measure.where(id: id).update_all({position: index+1})
  		end
  		render nothing: true
	end

	private
    def set_measure
      @measure = Measure.find(params[:id])
    end

    def measure_params
      params.require(:measure).permit(:name, :value, :collection_date, :scale, :position, :unit_of_measurement_id,
      									:metric_id)
	end
end