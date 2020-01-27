require 'rails_helper'

feature 'Admin register car' do
  scenario 'successfully' do
    user = User.create!(email: 'test#@test.com', password: '123456')
    manufacturer = Manufacturer.new(name: 'Fiat')
    CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                     car_category: CarCategory.new, manufacturer: manufacturer)
    Subsidiary.create!(name: 'Aeroporto Congonhas',
                       address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP',
                       cnpj: '28179836000114')

    login_as user, scope: :user
    visit root_path
    click_on 'Carros'
    click_on 'Registrar novo carro'
    fill_in 'Placa', with: 'EAE8164'
    fill_in 'Cor', with: 'Cinza'
    fill_in 'Quilometragem', with: 2.000
    select 'Aeroporto Congonhas', from: 'Filial'
    select 'Fiat Uno | 2018 | 1.5 | Flex', from: 'Modelo do Carro'
    click_on 'Enviar'

    expect(page).to have_content('EAE8164')
    expect(page).to have_content('Uno')
    expect(page).to have_content('2018')
    expect(page).to have_content(1.5)
    expect(page).to have_content('Flex')
    expect(page).to have_content('Aeroporto Congonhas')
    expect(page).to have_content('Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP')
  end

  scenario 'and must fill all the fields' do
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as user, scope: :user
    visit new_car_path
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('O cor deve ser informada')
    expect(page).to have_content('A placa não foi informada')
    expect(page).to have_content('A quilometragem deve ser informada')
  end

  scenario 'the field mileage accepts only numbers' do
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as user, scope: :user
    visit new_car_path
    fill_in 'Quilometragem', with: '123A'
    click_on 'Enviar'

    expect(page).to have_content('A quilometragem não aceita letras')
  end
end
