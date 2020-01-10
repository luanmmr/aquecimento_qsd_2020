class CarModelsController < ApplicationController

  before_action :collection_manufacturer, :collection_car_category, only: [:new, :edit]

  def new
    @car_model = CarModel.new
  end

  def create
    @car_model = CarModel.new(params_car_model)
    if @car_model.save
      redirect_to @car_model, notice: 'Modelo de carro criado com sucesso!'
    else
      collection_manufacturer
      collection_car_category
      render :new
    end
  end

  def index
    @car_models = CarModel.all
  end

  def show
    @car_model = CarModel.find(params[:id])
  end

  def edit
    @car_model = CarModel.find(params[:id])
  end

  def update
    @car_model = CarModel.find(params[:id])

    if @car_model.update(params_car_model)
      flash[:notice] = 'Modelo de carro editado com sucesso!'
      redirect_to car_model_path(@car_model)
    else
      collection_manufacturer
      collection_car_category
      render :edit
    end
  end

  def destroy
    CarModel.destroy(params[:id])
    redirect_to car_models_path, notice: 'Modelo de carro deletado com sucesso'
  end


  private

  def params_car_model
    params.require(:car_model).permit(:name, :year, :motorization, :fuel_type, :car_category_id, :manufacturer_id)
  end

  def collection_manufacturer
    @manufacturers = Manufacturer.all
  end

  def collection_car_category
    @car_categories = CarCategory.all
  end

end
