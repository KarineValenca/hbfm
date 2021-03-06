class FinalMeasuresController < ApplicationController
	before_action :set_final_measure, only: [:show, :edit, :update, :destroy]


	def new
		@final_measure_verify = FinalMeasure.last
		if @final_measure_verify.is_final != true
			@final_measure_verify.destroy
		end

		@metric = Metric.find(params[:metric])
		@final_measure = FinalMeasure.new(:metric_id => @metric)
		@measure = Measure.new
	end

	def create
		@final_measure = FinalMeasure.new(final_measure_params)
      	if @final_measure.save
      		respond_to do |format|
    			format.html { redirect_to final_measure_url }
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

	def edit
		@metric = Metric.find(@final_measure.metric_id)
		@measures = Measure.where(:final_measure_id => @final_measure.id)
	end

	def update
		@metric = Metric.find(@final_measure.metric_id)
		if @metric.scale == "Absoluta" || @metric.scale == "Ratio" || @metric.scale == "Intervalar"
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
		else
			##nothing to do
			
     	end	
	end

	def finalize_measure
		@final_measure = FinalMeasure.last
		update
		@final_measure.is_final = true

		@metric = Metric.find(@final_measure.metric_id)
		@final_measure.save
		redirect_to @metric
	end

	def import
		@metric = Metric.find(params[:id])
		FinalMeasure.import(params[:file], @metric)
		redirect_to @metric, notice: "Medidas importadas com sucesso"
	end


	private
    def set_final_measure
      @final_measure = FinalMeasure.find(params[:id])
    end

    def final_measure_params
      params.require(:final_measure).permit(:value, :operation, :metric_id)
	end
end