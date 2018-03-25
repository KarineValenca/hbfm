class MeasuresController < ApplicationController
	before_action :set_measure, only: [:show, :edit, :update, :destroy]

	def index
		 @measures = Measure.order(:position)
	end

	def new
		@measure = Measure.new
	end

	def create
		@measure = Measure.new(measure_params)
		# TODO: FIX THIS
		if  FinalMeasure.count == 0 || FinalMeasure.last.is_final
			puts "Criando medida final"
			FinalMeasure.create!(:metric_id => @measure.metric)
			respond_to do |format|
				format.js
			end
		else
			puts 'Não necessário criar medida final'
		end

		@final_measure = FinalMeasure.last
		@metric = Metric.find(@final_measure.metric_id)

		
		@measure.final_measure = @final_measure
		@measure.operator = "="

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

	def update
		puts "UPDATE METHOD"
		@measure = Measure.find(params[:id])
		@measure.update_attributes(measure_params)
	end

	def update_operator
		@operator = params[:operator]
		@measure = Measure.find(params[:measure])
		@measure.operator = @operator
		@measure.save
	end

	def sort
		@final_measure = FinalMeasure.last
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
      params.require(:measure).permit(:name, :value, :collection_date, :scale, :operator, :position, :metric,
      								 :unit_of_measurement_id, :final_measure_id)
	end
end