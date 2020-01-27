class Subsidiary < ApplicationRecord

  has_many :cars

  validates :name,
  presence: {message: 'O campo nome deve ser preenchido'}

  validates :address,
  presence: {message: 'O campo endereço deve ser preenchido'},
  uniqueness: {message: 'Já há uma filial cadastrada nesse endereço', case_sensitive: false},
  format: {with: /\A(Rua|RUA|Av|AV)\s{1}.+,\s{1}\d+,\s{1}.+,\s{1}[a-zA-Z]{2}\z/, message: 'O endereço deve estar no formato: Rua/Av nome da rua ou avenida, 70, nome do bairro, SP'}

  validates :cnpj,
  presence: {message: 'O campo CNPJ deve ser preenchido'},
  length: {is: 14, message: 'O CNPJ deve ter 14 números'},
  numericality: {only_integer: true, message: 'Digite apenas números no CNPJ'}


  after_validation :formatting


  def formatting
    self.name = name.downcase.titleize if name.present?
  end

end
