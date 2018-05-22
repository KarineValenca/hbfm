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
			FinalMeasure.create!(:collect_date => @measure.collect_date, :metric_id => @measure.metric)
			respond_to do |format|
				format.js
			end
		else
			puts 'Não necessário criar medida final'
		end

		@final_measure = FinalMeasure.last
		@metric = Metric.find(@final_measure.metric_id)

		
		@measure.final_measure = @final_measure
		@measure.operator = "+"

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

	def edit
		@final_measure = FinalMeasure.find(@measure.final_measure_id)
	end

	def update
		@measure = Measure.find(params[:id])
		@final_measure = FinalMeasure.find(@measure.final_measure_id)
		@metric = Metric.find(@final_measure.metric_id)
		@measure.update_attributes(measure_params)

		if @metric.scale == "Nominal" || @metric.scale == "Ordinal"
    		redirect_to @metric
  		end

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
      params.require(:measure).permit(:name, :value, :collect_date, :operator, :position, :metric,
      								  :final_measure_id)
	end
end