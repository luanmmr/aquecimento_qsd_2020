class RentalsController < ApplicationController
  before_action :authenticate_user!
  before_action :clients_collection, :categories_collection, only: [:new, :edit]

  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(params_rental)
    @rental.code = SecureRandom.hex(5)
    @rental.user = current_user

    return redirect_to rental_path(@rental), notice: 'Locação agendada com sucesso' if @rental.save

    clients_collection
    categories_collection
    render :new
  end

  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def destroy
    Rental.destroy(params[:id])
    redirect_to rentals_path, notice: 'Locação deletada com sucesso'
  end

  def search
    # Busca exata
    #@rentals = Rental.where(code: params[:q])
    # Outro modo de busca exata, agora, utilizando SQL
    #@rentals = Rental.where("code LIKE ?", "#{params[:q]}")
    @q = params[:q]
    @rentals = Rental.where("code LIKE ?", "%#{params[:q]}%")
  end

  def reserve
    @rental = Rental.find(params[:id])
    @car_rental = CarRental.new
    @cars = Car.where(car_model: @rental.car_category.car_models)
  end

  def create_reserve
    @rental = Rental.find(params[:id])
    @car = Car.find(params[:car_rental][:car_id])
    @car_rental = CarRental.new(car: @car, rental: @rental, daily_price: @rental.daily_price_total,
                                car_insurance: @rental.car_insurance,
                                third_party_insurance: @rental.third_party_insurance,
                                start_mileage: @car.mileage)
    @car_rental.save!
    redirect_to car_rental_path(@car_rental), notice: "Locação efetivada"
  end


  private

  def clients_collection
    @clients = Client.all
  end

  def categories_collection
    @car_categories = CarCategory.all
  end

  def params_rental
    params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id)
  end

  def params_create_reserve
    params.require(:car_rental).permit(:car_id, :id)
  end

end
