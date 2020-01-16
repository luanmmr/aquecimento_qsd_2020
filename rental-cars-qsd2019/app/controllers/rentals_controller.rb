class RentalsController < ApplicationController

  before_action :authenticate_user!
  before_action :clients_car_categories_collections, only: [:new, :edit]


  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(params_rental)
    @rental.code = SecureRandom.hex(5)
    @rental.user = current_user

    return redirect_to rental_path(@rental), notice: 'Locação agendada com sucesso' if @rental.save

    clients_car_categories_collections

    render :new

  end

  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
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
    @cars = Car.all.select do |car|
       car.car_model.car_category.name == @rental.car_category.name && car.disponivel_status?
    end
  end

  def create_reserve
    @car_rental = CarRental.new(car_id: params[:car_rental][:car_id], rental_id: params[:id])
    @car_rental.daily_rate = @car_rental.rental.car_category.daily_rate +
                             @car_rental.rental.car_category.car_insurance +
                             @car_rental.rental.car_category.third_party_insurance

    if @car_rental.save
    @car_rental.car.indisponivel_status!
    @car_rental.rental.em_andamento_status!
    return redirect_to show_reserve_rental_path(@car_rental), notice: "Locação efetivada"
    end

    @rental = Rental.find(params[:id])
    @car_rental = CarRental.new
    @cars = Car.all.select do |car|
       car.car_model.car_category.name == @rental.car_category.name && car.disponivel_status?
    end

    render :reserve

  end

  def show_reserve
    @car_rental = CarRental.find(params[:id])
  end




  private

  def clients_car_categories_collections
    @clients = Client.all
    @car_categories = CarCategory.all
  end

  def params_rental
    params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id)
  end

  def params_create_reserve
    params.require(:car_rental).permit(:car_id, :id)
  end

end
