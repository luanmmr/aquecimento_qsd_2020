require 'rails_helper'

feature 'Admin view car' do
  scenario 'successfully' do
    user = User.create!(email: 'test#@test.com', password: '123456')
    subsidiary = Subsidiary.new(name: 'Av Paulista', cnpj: '28179836000114',
                                address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP')
    manufacturer = Manufacturer.new(name: 'Fiat')
    car_category = CarCategory.new(name: 'A', daily_rate: 120.00, car_insurance: 40.50,
                                   third_party_insurance: 15)
    car_model = CarModel.new(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                             car_category: car_category, manufacturer: manufacturer)
    Car.create!(license_plate: 'JSO1245', color: 'Azul', car_model: car_model,
                mileage: 100, subsidiary: subsidiary)
    other_manufacturer = Manufacturer.new(name: 'Honda')
    other_car_category = CarCategory.new(name: 'B', daily_rate: 120.00, car_insurance: 40.50,
                                         third_party_insurance: 15)
    other_car_model = CarModel.new(name: 'Fit', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                                   car_category: other_car_category, manufacturer: other_manufacturer)
    Car.create!(license_plate: 'PLU1245', color: 'Verde', car_model: other_car_model,
                mileage: 100, subsidiary: subsidiary)

    login_as user, scope: :user
    visit root_path
    click_on 'Carros'

    expect(page).to have_content('JSO1245')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('Uno')
    expect(page).to have_content('Av Paulista')
    expect(page).to have_content('PLU1245')
    expect(page).to have_content('Honda')
    expect(page).to have_content('Fit')
    expect(page).to have_content('Av Paulista')
  end

  scenario 'and also details' do
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

    login_as user, scope: :user
    visit cars_path
    click_on 'JSO1245'

    expect(page).to have_content('JSO1245')
    expect(page).to have_content('Fiat')
    expect(page).to have_content('Uno')
    expect(page).to have_content('2018')
    expect(page).to have_content('1.5')
    expect(page).to have_content('Flex')
    expect(page).to have_content('Av Paulista')
    expect(page).to have_content('Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP')
  end
end
