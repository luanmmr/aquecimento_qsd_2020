class CarCategory < ApplicationRecord

  has_many :car_models
  has_many :cars, through: :car_models
  has_many :rentals, through: :cars


  validates :name,
  presence: {message: 'O campo nome está vazio'},
  uniqueness: {message: 'Já existe uma categoria com este nome', case_sensitive: false},
  format: {with: /\A[A-Z]+\z/, message: 'Insira no nome apenas letras maíusculas'}

  validates :daily_rate,
  presence: {message: 'A diária está vazia'},
  numericality: {greater_than: 1, message: 'Campo diária com valor inválido'}

  validates :car_insurance,
  presence: {message: 'O seguro do carro está vazio'},
  numericality: {greater_than: 1, message: 'Campo seguro do carro com valor inválido'}

  validates :third_party_insurance,
  presence: {message: 'O seguro para terceiros está vazio'},
  numericality: {greater_than: 1, message: 'Campo seguro para terceiros com valor inválido'}


  after_validation :formatting


  private
  def formatting
    self.name = name.downcase.titleize if name.present?
  end

end
