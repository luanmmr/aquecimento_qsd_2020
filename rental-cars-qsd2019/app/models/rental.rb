class Rental < ApplicationRecord

  belongs_to :client
  belongs_to :car_category
  belongs_to :user

  validates :start_date,
  presence: {message: 'Você deve informar uma data de início'}

  validates :end_date,
  presence: {message: 'Não foi informado a data de fim'}

  enum status: {agendada: 0, em_andamento: 1}, _prefix: true



  def daily_price
    car_category.daily_rate + car_category.car_insurance + car_category.third_party_insurance
  end

end
