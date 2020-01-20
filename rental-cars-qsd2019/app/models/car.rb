class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary

  enum status: {disponivel: 0, indisponivel: 1}, _prefix: true

  def full_description
    return 'Carro não cadastro corretamente' if car_model.nil? || subsidiary.nil?
    "#{car_model.manufacturer.name} #{car_model.name} - #{color} - #{license_plate}"
  end

  def car_category
    car_model.car_category
  end

end
