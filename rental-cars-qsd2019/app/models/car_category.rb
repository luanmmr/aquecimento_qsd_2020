class CarCategory < ApplicationRecord

  has_many :car_models, dependent: :destroy


  validates :name,
  presence: {message: 'O campo nome está vazio'},
  uniqueness: {message: 'Já existe uma categoria com este nome', case_sensitive: false},
  format: {with: /\A[A-Z]+\z/, message: 'Insira no nome apenas letras maíusculas'}

  validates :daily_rate,
  presence: {message: 'A diária está vazia'},
  numericality: {message: 'O campo diária só aceita números'}

  validates :car_insurance,
  presence: {message: 'O seguro do carro está vazio'},
  numericality: {message: 'Informe um valor para o seguro do carro'}

  validates :third_party_insurance,
  presence: {message: 'O seguro para terceiros está vazio'},
  numericality: {message: 'Informe um valor para o seguro de terceiros'}


  after_validation :formatting


  private
  def formatting
    self.name = name.downcase.titleize
  end

end
