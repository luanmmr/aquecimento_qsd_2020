class CarModel < ApplicationRecord

  has_many :cars
  belongs_to :manufacturer
  belongs_to :car_category


  validates :name,
  presence: {message: 'O campo nome está vazio'},
  uniqueness: {message: 'Este modelo de carro já existe nesta categoria', case_sensitive: false, scope: [:year, :car_category_id]}

  validates :year,
  presence: {message: 'Preencha o campo ano'}

  validates :motorization,
  presence: {message: 'Você deve informar a motorização'}

  validates :fuel_type,
  presence: {message: 'Ops, você se esqueceu do tipo de combustível'}


  after_validation :formatting


  private
  def formatting
    self.name = name.downcase.titleize
    self.fuel_type = fuel_type.downcase.titleize
  end

end
