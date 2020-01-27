class CarRental < ApplicationRecord

  belongs_to :car
  belongs_to :rental


  validates :daily_price, presence: {message: 'O valor total da diária deve ser fornecida'},
  numericality: {message: 'A taxa diária só aceita números'}

  validates :car_insurance, presence: {message: 'Valor do seguro não informado'},
  numericality: {message: 'O seguro do carro só aceita números'}

  validates :third_party_insurance, presence: {message: 'O valor do seguro para terceiros não informado'},
  numericality: {message: 'O seguro para terceiros só aceita números'}

  validates :start_mileage, presence: {message: 'Informo a quilometragem inicial'},
  numericality: {message: 'A quilometragem só aceita números'}

  validate :check_car_category

  after_create :rental_status_change



  private

  def rental_status_change
    rental.status_em_andamento!
  end

  def check_car_category
    if car && rental
      if car.car_model.car_category != rental.car_category
        errors.add(:base, 'Categoria do carro e da locação não são a mesma.')
      end
    end
  end


end
