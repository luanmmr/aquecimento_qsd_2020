class Rental < ApplicationRecord

  belongs_to :client
  belongs_to :car_category
  belongs_to :user
  has_one :car_rental

  validates :start_date,
  presence: true

  validates :end_date,
  presence: true

  validate :valid_start_date, :valid_end_date
  validate :availables_cars, on: [:create, :save]

  enum status: {agendada: 0, em_andamento: 1}, _prefix: true


  def valid_start_date
    if start_date && start_date < Date.today
      message = I18n.t(:invalid_start_date, scope:
                       [:activerecord, :methods, :rental, :valid_start_date])
      errors.add(:start_date, message)
    end
  end

  def valid_end_date
    if end_date && end_date < start_date
      message = I18n.t(:invalid_end_date, scope:
                       [:activerecord, :methods, :rental, :valid_end_date])
      errors.add(:end_date, message)
    end
  end

  def availables_cars
    # Será buscado todos os carros ONDE o car_model deles são iguais os
    # car_models de car_category
    if car_category && !car_category.car_models.empty?
      category_cars = Car.where(car_model: car_category.car_models)
      # unavaible_cars = category_rentals.where('start_date BETWEEN ? AND ?',
      # start_date, end_date).or('end_date BETWEEN ? AND ?',
      # start_date, end_date)
      rented_cars = Rental.where(car_category: car_category)
                          .where(start_date: start_date..end_date)
                          .or(Rental.where(car_category: car_category)
                          .where(end_date: start_date..end_date))
                          .or(Rental.where(car_category: car_category)
                          .where("start_date < ? AND end_date > ?",
                          "#{start_date}", "#{end_date}"))
        message = I18n.t(:no_car, scope:
                         [:activerecord, :methods, :rental, :availables_cars])
        if rented_cars.length >= category_cars.length
          errors[:base] << message
        end
      end
    end

  def daily_price_total
    if car_category.present?
       car_category.daily_rate + car_category.car_insurance +
       car_category.third_party_insurance
    else
       I18n.t(:incomplete_rental, scope: [
                                       :activerecord, :methods, :rental,
                                       :daily_price_total
                                      ])
    end
  end

  def car_insurance
    if car_category.present?
      car_category.car_insurance
    else
      I18n.t(:incomplete_rental, scope: [
                                      :activerecord, :methods, :rental,
                                      :daily_price_total
                                     ])
    end
  end

  def third_party_insurance
    if car_category.present?
     car_category.third_party_insurance
    else
     I18n.t(:incomplete_rental, scope: [
                                     :activerecord, :methods, :rental,
                                     :daily_price_total
                                    ])
    end
  end

end
