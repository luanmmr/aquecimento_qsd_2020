class Manufacturer < ApplicationRecord

  has_many :car_models, dependent: :destroy


  validates :name, presence: {message: 'Nome não pode ficar em branco'},
  uniqueness: {message: 'Fabricante já cadastrada', case_sensitive: false},
  format: {with: /\A[a-zA-Z]{2,}\z/, message: 'Nome composto ou caracteres inválidos'}


  after_validation :formatting


  private
  def formatting
    self.name = name.downcase.titleize
  end

end
