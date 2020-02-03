require 'rails_helper'

feature 'Admin edit car' do
  scenario 'successfully' do
    user = create(:user)
    create(:subsidiary, name: 'Interlagos', cnpj: '92143681000611',
                        address: 'Av Interlagos', number: 70,
                        district: 'Jd Marajoara', zip_code: '75004203')
    car_category = create(:car_category, name: 'W', daily_rate: 109.99,
                                         car_insurance: 30.00,
                                         third_party_insurance: 15.00)
    manufacturer = create(:manufacturer, name: 'Honda')
    create(:car_model, name: 'Fit', motorization: '1.4', year: '2012',
                       car_category: car_category, manufacturer: manufacturer)
    car = create(:car)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    within "td#car-#{car.id}" do
      click_on 'Editar'
    end
    fill_in 'Placa', with: 'MVU1245'
    select 'Honda Fit | 2012 | 1.4 | Flex', from: 'Modelo do Carro'
    select 'Interlagos', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Cliente editado com sucesso')
    expect(page).to have_content('MVU1245')
    expect(page).to have_content('Honda')
    expect(page).to have_content('Fit')
    expect(page).to have_content('Interlagos')
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
