class Client < ApplicationRecord

  has_many :rentals

  validates :name,
  presence: {message: 'Nome não pode ficar em branco'},
  format: {with: /\A([a-zA-Z]+|[a-zA-Z]+\s{1}[a-zA-Z]+)\z/, message: 'Nome inválido'}

  validates :email,
  presence: {message: 'Email não pode ficar em branco'},
  format: {with: /\A.+@[a-z]+.([a-z]+|[a-z]+.[a-z]+)\z/, message: 'Email com formato inválido'}

  validates :document,
  presence: {message: 'CPF não pode ficar em branco'},
  length: {maximum: 11, message: 'O CPF é composto de até 11 algarismo.'}

end
