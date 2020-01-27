class Rental < ApplicationRecord

  belongs_to :client
  belongs_to :car_category
  belongs_to :user
  has_one :car_rental

  validates :start_date,
  presence: {message: 'Você deve informar uma data de início'}

  validates :end_date,
  presence: {message: 'Não foi informado a data de fim'}

  validate :start_date_valid, :end_date_valid
  validate :availables_cars, on: :create

  enum status: {agendada: 0, em_andamento: 1}, _prefix: true



  def start_date_valid
    if start_date && start_date < Date.current
      errors.add(:start_date, 'Data de início deve ser a partir da data atual')
    end
  end

  def end_date_valid
    if end_date && end_date < start_date
      errors.add(:end_date, 'Data de término deve ser após data de início')
    end
  end

  def availables_cars
    # Será buscado todos os carros ONDE o car_model deles são iguais os car_models de car_category
    if car_category && !car_category.car_models.empty?
      category_cars = Car.where(car_model: car_category.car_models)
      # unavaible_cars = category_rentals.where('start_date BETWEEN ? AND ?', start_date,
      # end_date).or('end_date BETWEEN ? AND ?', start_date, end_date)
      rented_cars = Rental.where(car_category: car_category)
                          .where(start_date: start_date..end_date)
                          .or(Rental.where(car_category: car_category)
                          .where(end_date: start_date..end_date))
                          .or(Rental.where(car_category: car_category)
                          .where("start_date < ? AND end_date > ?",
                          "#{start_date}", "#{end_date}"))

        if rented_cars.length >= category_cars.length
          errors[:base] << 'Não há carros dessa categoria disponível para o período'
        end
      end
    end


  def daily_price_total
    car_category.daily_rate + car_category.car_insurance + car_category.third_party_insurance
  end

  def car_insurance
    car_category.car_insurance
  end

  def third_party_insurance
    car_category.third_party_insurance
  end

end
