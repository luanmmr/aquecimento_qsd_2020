class CarModelsController < ApplicationController


  def new
    @car_model = CarModel.new
  end

  def create
    @car_model = CarModel.new(params_car_model)
    if @car_model.save
      flash[:notice] = 'Modelo de carro criado com sucesso!'
      redirect_to @car_model
    else
      render :new
    end
  end

  def index
    @car_models = CarModel.all
  end

  def show
    @car_model = CarModel.find(params[:id])
  end


  private
  def params_car_model
    params.require(:car_model).permit(:name, :year, :motorization, :fuel_type)
  end

end
