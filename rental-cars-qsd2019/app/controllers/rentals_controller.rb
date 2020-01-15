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
    @rentals = Rental.where("code LIKE ?", "%#{params[:q]}%")
  end




  private

  def clients_car_categories_collections
    @clients = Client.all
    @car_categories = CarCategory.all
  end

  def params_rental
    params.require(:rental).permit(:start_date, :end_date, :client_id, :car_category_id)
  end

end
