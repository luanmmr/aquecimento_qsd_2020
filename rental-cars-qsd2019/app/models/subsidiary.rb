class Subsidiary < ApplicationRecord

  has_many :cars

  validates :name,
  presence: {message: 'O campo nome deve ser preenchido'}

  validates :address,
  presence: {message: 'O campo endereço deve ser preenchido'}

  validates :cnpj,
  presence: {message: 'O campo CNPJ deve ser preenchido'},
  length: {is: 14, message: 'O CNPJ deve ter 14 números'},
  numericality: {only_integer: true, message: 'Digite apenas números no CNPJ'}

  validates :zip_code,
  presence: {message: 'O CEP deve ser informado'},
  numericality: {message: 'Forneça apenas números para o CEP, sem hífen ou '\
                          'pontos', only_integer: true},
  length: {is: 8, message: 'O CEP deve ter 8 números'}

  validates :number,
  presence: {message: 'O número deve ser informado'},
  uniqueness: {scope: :zip_code, message: 'Essa filial já existe'},
  numericality: {message: 'Existe caracteres inválidos no número'}

  validates :district,
  presence: {message: 'Informe o bairro'}

  validates :state,
  presence: {message: 'O estado não foi informado'},
  length: {is: 2, message: 'Insira a sigla do estado'}

  validates :city,
  presence: {message: 'A cidade não foi informada'}


  after_validation :formatting


  private

  def full_description
    if name.present? && address.present?
      "#{name}: #{address}"
    else
      "Filial cadastrada incorretamente"
    end
  end

  def formatting
    self.name = name.downcase.titleize if name.present?
  end

end
