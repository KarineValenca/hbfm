class FinalMeasuresController < ApplicationController
	before_action :set_final_measure, only: [:show, :edit, :update, :destroy]


	def new
		@metric = Metric.find(params[:metric])
		@final_measure = FinalMeasure.new
		@measure = Measure.new
	end

	def create
		@final_measure = FinalMeasure.new(final_measure_params)
      	if @final_measure.save
      		respond_to do |format|
    			format.html { redirect_to final_measures_url }
			    format.js
  			end
  			
  			else
		        format.html { render :new }
		        format.json { render json: @final_measure.errors, status: :unprocessable_entity }
      		end

      	
	end

	def show

	end


	private
    def set_final_measure
      @final_measure = FinalMeasure.find(params[:id])
    end

    def final_measure_params
      params.require(:final_measure).permit(:value, :operation, :metric_id)
	end
end