class CarRental < ApplicationRecord
  belongs_to :car
  belongs_to :rental

  after_create :car_status_change, :rental_status_change

  validate :check_car_category, :check_car_availability


  def car_status_change
    car.status_indisponivel!
  end

  def rental_status_change
    rental.status_em_andamento!
  end

  def check_car_category
    if car && rental
      if car.car_model.car_category != rental.car_category
        errors.add(:car, ' não é mais da mesma categoria da alocação')
      end
    end
  end

  def check_car_availability
    if car
      errors.add(:car, ' não está mais disponível') unless car.status_disponivel?
    end
  end

end
