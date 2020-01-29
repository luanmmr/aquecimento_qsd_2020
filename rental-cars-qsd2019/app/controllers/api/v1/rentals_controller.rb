class Api::V1::RentalsController < Api::V1::ApiController

  def create
    @rental = Rental.new(rental_params)
    render json: @rental, status: :ok if @rental.save!

  rescue ActiveRecord::RecordInvalid
    render json: @rental.errors, status: 412
  end


  private

  def rental_params
    params.permit(:code, :start_date, :end_date, :client_id, :car_category_id,
                  :user_id)
  end

end
