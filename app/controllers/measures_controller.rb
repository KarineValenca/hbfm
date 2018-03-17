class MeasuresController < ApplicationController
	before_action :set_measure, only: [:show, :edit, :update, :destroy]

	def index
		 @measures = Measure.order(:position)
	end

	def new
		@measure = Measure.new
	end

	def create
		# TODO: FIX THIS
		if  FinalMeasure.count == 0 || FinalMeasure.last.value != nil
			FinalMeasure.create!(:metric_id => @metric.id)
		else
			puts 'Não necessário criar medida final'
		end

		@final_measure = FinalMeasure.last
		@metric = Metric.find(@final_measure.metric_id)

		@measure = Measure.new(measure_params)
		@measure.final_measure = @final_measure
		print '*' * 90
		puts "#{@measure.final_measure}"
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
      									:final_measure_id)
	end
end