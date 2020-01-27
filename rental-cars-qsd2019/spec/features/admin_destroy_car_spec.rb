require 'rails_helper'

feature 'Admin destroys car' do
  scenario 'successfully' do
    user = User.create!(email: 'test#@test.com', password: '123456')
    subsidiary = Subsidiary.new(name: 'Av Paulista', cnpj: '28179836000114',
                                address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP')
    manufacturer = Manufacturer.new(name: 'Fiat')
    car_category = CarCategory.new(name: 'A', daily_rate: 120.00, car_insurance: 40.50,
                                   third_party_insurance: 15)
    car_model = CarModel.new(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                             car_category: car_category, manufacturer: manufacturer)
    car = Car.create!(license_plate: 'JSO1245', color: 'Azul', car_model: car_model,
                      mileage: 100, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit car_path(car)
    click_on 'Deletar'

    expect(page).to have_content('Carro deletado com sucesso')
  end
end
