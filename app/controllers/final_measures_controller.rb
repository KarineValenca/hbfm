class FinalMeasuresController < ApplicationController
	before_action :set_final_measure, only: [:show, :edit, :update, :destroy]


	def new
		@metric = Metric.find(params[:metric])
		@final_measure = FinalMeasure.new(:metric_id => @metric)
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
		update
		respond_to do |format|
  			format.js {render layout: false} # Add this line to you respond_to block
		end
  		
	end


	def update
		puts "UPDATE MATHOD" * 90
		@measures = Measure.where(final_measure_id: @final_measure.id).order(:position)

		@final_value = 0
		@final_measure.operation = ""


     	@measures.each do |measure|
     		if measure == @measures.last
     			measure.operator = ""
     		end
     		@final_measure.operation << measure.value.to_s + measure.operator
     	end

     	#@final_measure.value = 0
     	@final_measure.value = eval(@final_measure.operation)
     	@final_measure.save

     	
	end

	def finalize_measure
		@final_measure = FinalMeasure.last
		@final_measure.is_final = true

		@final_measure.save

		redirect_to metrics_path
	end


	private
    def set_final_measure
      @final_measure = FinalMeasure.find(params[:id])
    end

    def final_measure_params
      params.require(:final_measure).permit(:value, :operation, :metric_id)
	end
end