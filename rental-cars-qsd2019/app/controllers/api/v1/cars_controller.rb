class Api::V1::CarsController < Api::V1::ApiController

  def create
    @car = Car.new(car_params)
    render json: @car, status: 201 if @car.save!

  rescue ActiveRecord::RecordInvalid
    render json: @car.errors, status: 412
  end

  def index
    @cars = Car.all
    return render json: @cars, status: :ok unless @cars.empty?
    render json: '', status: 204
  end

  def show
    @car = Car.find(params[:id])
    render json: @car, status: :ok if @car.present?

  rescue ActiveRecord::RecordNotFound
    render json: '', status: :not_found
  end

  def update
    @car = Car.find(params[:id])
    render json: @car, status: 200 if @car.update!(car_params)

  rescue ActiveRecord::RecordNotFound
    render json: '', status: 404
  rescue ArgumentError
    render plain: 'Não houve atualização - Dados invalidos', status: 412
  end


  private

  def car_params
    default_keys = 3
    if params.keys.length > default_keys
      params.permit(:license_plate, :color, :car_model_id, :mileage, :subsidiary_id)
    end
  end

end
