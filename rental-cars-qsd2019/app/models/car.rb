class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary

  enum status: {disponivel: 0, indisponivel: 1}, _suffix: true

  def view_car
    "#{car_model.name} - #{color} - #{license_plate}"
  end

end
