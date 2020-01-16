require 'rails_helper'

feature 'User register car rental' do
  scenario 'successfully' do

    user = User.create!(email: 'teste@hotmail.com', password: '123456')
    client = Client.create!(name: 'Fulano', document: '2938248684', email: 'fulano@test.com')
    car_category =  CarCategory.create!(name: 'A', daily_rate: 72.20, car_insurance: 28.00, third_party_insurance: 10.00)
    Rental.create!(code: 'XFB0000', start_date: Date.current, end_date: 1.day.from_now, client: client, car_category: car_category, user: user)
    subsidiary = Subsidiary.create(name: 'Aeroporto Congonhas', address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP', cnpj: '28179836000114')
    manufacturer = Manufacturer.create(name: 'Fiat')
    car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex', car_category: car_category, manufacturer: manufacturer)
    Car.create!(license_plate: 'MVL7266', color: 'Vermelho', car_model: car_model, mileage: 120.00, subsidiary: subsidiary, status: 0)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    click_on 'XFB0000'
    click_on 'Efetivar locação'
    select 'Uno - Vermelho - MVL7266', from: 'Carros disponíveis'
    click_on 'Efetivar'

    expect(page).to have_content('Locação efetivada')
    expect(page).to have_content('Uno')
    expect(page).to have_content('MVL7266')
    expect(page).to have_content('Fulano')
    expect(page).to have_content('2938248684')
    expect(page).to have_content('110.20')
    expect(page).to have_content('em_andamento')

  end
end
