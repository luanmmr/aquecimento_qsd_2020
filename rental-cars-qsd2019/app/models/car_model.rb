class CarModel < ApplicationRecord

  has_many :cars
  belongs_to :manufacturer
  belongs_to :car_category


  validates :name,
  presence: {message: 'O campo nome está vazio'},
  uniqueness: {message: 'Este modelo de carro já existe nesta categoria',
               case_sensitive: false, scope: [:year, :motorization, :fuel_type]}

  validates :year,
  presence: {message: 'Preencha o campo ano'}

  validates :motorization,
  presence: {message: 'Você deve informar a motorização'}

  validates :fuel_type,
  presence: {message: 'Ops, você se esqueceu do tipo de combustível'}

  after_validation :formatting


  private

  def formatting
    if name.present? && fuel_type.present?
      self.name = name.downcase.titleize
      self.fuel_type = fuel_type.downcase.titleize
    else
      'Este modelo foi criado incompleto'
    end
  end

  def full_description
    if name.present? && manufacturer.present?
      "#{manufacturer.name} #{name} | #{year} | #{motorization} | #{fuel_type}"
    else
      "Modelo de carro cadastrado incorretamente!"
    end
  end

end
