class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  has_one :car_rental


  validates :color,
  presence: {message: 'O cor deve ser informada'}

  validates :license_plate,
  presence: {message: 'A placa não foi informada'}


  def full_description
    if car_model.nil? || color.nil? || license_plate.nil?
      'Carro não cadastro corretamente'
    else
      "#{car_model.manufacturer.name} #{car_model.name} - #{color} - #{license_plate}"
    end
  end

  def car_category
    car_model.car_category
  end

end
