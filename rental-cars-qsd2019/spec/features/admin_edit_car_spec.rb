require 'rails_helper'

feature 'Admin edit car' do
  scenario 'successfully' do
    user = User.create!(email: 'test#@test.com', password: '123456')
    subsidiary = Subsidiary.create!(name: 'Av Paulista', cnpj: '28179836000114',
                                address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP')
    other_subsidiary = Subsidiary.create!(name: 'Capão Redondo', cnpj: '82719836000411',
                                      address: 'Rua Elias maas, 179, Capão Redondo, SP')
    manufacturer = Manufacturer.create!(name: 'Fiat')
    car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                             car_category: CarCategory.new, manufacturer: manufacturer)
    car_model = CarModel.create!(name: 'Punto', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                                 car_category: CarCategory.new, manufacturer: manufacturer)
    Car.create!(license_plate: 'JSO1245', color: 'Azul', car_model: car_model,
                mileage: 100, subsidiary: subsidiary)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'JSO1245'
    click_on 'Editar'
    fill_in 'Placa', with: 'MVU1245'
    select 'Fiat Punto | 2018 | 1.5 | Flex', from: 'Modelo do Carro'
    select 'Capão Redondo', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Cliente editado com sucesso')
    expect(page).to have_content('MVU1245')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('Punto')
    expect(page).to have_content('Capão Redondo')
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'test#@test.com', password: '123456')
    car = Car.create!(license_plate: 'JSO1245', color: 'Azul', car_model: CarModel.new,
                mileage: 100, subsidiary: Subsidiary.new)

    login_as(user, scope: :user)
    visit edit_car_path(car)
    fill_in 'Placa', with: ''
    fill_in 'Cor', with: ''
    fill_in 'Quilometragem', with: ''
    click_on 'Enviar'

    expect(page).to have_content('O cor deve ser informada')
    expect(page).to have_content('A placa não foi informada')
    expect(page).to have_content('A quilometragem deve ser informada')
  end
end
