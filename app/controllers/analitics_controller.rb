class AnaliticsController < ApplicationController
  def index
    @analitics = Analitic.all
  end

  def new
    @analitic = Analitic.new
  end

  def create
    @data_file = DataFile.new(analitic_params)

    respond_to do |format|
      if @data_file.save
        Analitic.create(SmarterCSV.process(File.open(@data_file.file.path)))
        format.html { redirect_to new_analitic_path, notice: 'Data File was successfully uploaded.' }
      else
        format.html { render :new }
      end
    end
  end

  def filter
    @selected = Analitic.get_data_based_on_dates(analitic_selected_params, "selected")
    @compared = Analitic.get_data_based_on_dates(analitic_compared_params, "compared")
    @all_data = @selected + @compared
    render :index
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def analitic_params
      params.require(:analitic).permit(:file)
    end

    def analitic_selected_params
      params.require(:analitic).permit(:start_date, :end_date)
    end

    def analitic_compared_params
      params.require(:analitic).permit(:compared_to_start_date, :compared_to_end_date)
    end
end
