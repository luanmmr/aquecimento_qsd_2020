class CarCategoriesController < ApplicationController

  before_action :authenticate_user!#, only: [:index, :show]


  def new
    @car_category = CarCategory.new
  end

  def create
    @car_category = CarCategory.new(params_car_category)
    if @car_category.save
      flash[:notice] = 'Cadastrada com sucesso'
      redirect_to @car_category
    else
      render :new
    end
  end

  def index
    @car_categories = CarCategory.all
  end

  def show
    @car_category = CarCategory.find(params[:id])
  end

  def edit
    @car_category = CarCategory.find(params[:id])
  end

  def update
    @car_category = CarCategory.find(params[:id])
    if @car_category.update(params_car_category)
      flash[:notice] = 'Alteração realizada com sucesso'
      redirect_to @car_category
    else
      render :edit
    end
  end

  def destroy
    CarCategory.destroy(params[:id])
    redirect_to car_categories_path, notice: 'Categoria de carro deletada com sucesso'
  end



  private

  def params_car_category
    params.require(:car_category).permit(:name, :daily_rate, :car_insurance, :third_party_insurance)
  end



end
