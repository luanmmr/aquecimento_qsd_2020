class CarModel < ApplicationRecord

  validates :name,
  presence: {message: 'O campo nome está vazio'},
  uniqueness: {message: 'Este modelo de carro já existe', case_sensitive: false}

  validates :year,
  presence: {message: 'Preencha o campo Ano'}

  validates :motorization,
  presence: {message: 'Você deve informar a Motorização'}

  validates :fuel_type,
  presence: {message: 'Ops, você se esqueceu do Tipo de Combustível'}

end
