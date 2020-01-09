class Manufacturer < ApplicationRecord
  validates :name, presence: {message: 'Nome não pode ficar em branco'},
  uniqueness: {message: 'Fabricante já cadastrada', case_sensitive: false},
  format: {with: /\A[a-zA-Z]{2,}\z/, message: 'Nome composto ou caracteres inválidos'}

end
