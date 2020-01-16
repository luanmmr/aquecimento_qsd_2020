class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  belongs_to :user

  enum status: {agendada: 0, em_andamento: 1}, _suffix: true

end
