require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do

    manufacturer = Manufacturer.create(name: 'Fiat')
    car_category = CarCategory.create(name: 'A', daily_rate: 120.00, car_insurance: 40.50, third_party_insurance: 15)

    user = User.create!(email: 'test#@test.com', password: '123456')
    login_as(user, :scope => :user)

    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Registrar modelo de carro'

    fill_in 'Nome', with: 'Fiesta'
    fill_in 'Ano', with: '2020'
    fill_in 'Motorização', with: '1.8'
    fill_in 'Tipo de Combustível', with: 'Gasolina'
    select 'Fiat', from: 'Fabricante'
    select 'A', from: 'Categoria do Carro'

    click_on 'Enviar'

    expect(page).to have_content('Modelo de carro criado com sucesso!')
    expect(page).to have_content('Fiesta')
    expect(page).to have_content('2020')
    expect(page).to have_content('1.8')
    expect(page).to have_content('Gasolina')
    expect(page).to have_content('Fiat')
    expect(page).to have_content(/A/)

  end

  scenario 'and must fill in all fields' do

    user = User.create!(email: 'test#@test.com', password: '123456')
    login_as(user, :scope => :user)

    visit new_car_model_path

    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('O campo nome está vazio')
    expect(page).to have_content('Preencha o campo ano')
    expect(page).to have_content('Você deve informar a motorização')
    expect(page).to have_content('Ops, você se esqueceu do tipo de combustível')
  end

  scenario 'name must be unique' do

    user = User.create!(email: 'test#@test.com', password: '123456')
    login_as(user, :scope => :user)

    manufacturer = Manufacturer.create(name: 'Fiat')
    car_category = CarCategory.create(name: 'A', daily_rate: 120.00, car_insurance: 40.50, third_party_insurance: 15)
    CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex', car_category_id: car_category.id, manufacturer_id: manufacturer.id)

    visit new_car_model_path

    fill_in 'Nome', with: 'Uno'
    fill_in 'Ano', with: '2018'
    select 'A', from: 'Categoria do Carro'
    click_on 'Enviar'

    expect(page).to have_content('Este modelo de carro já existe nesta categoria')

  end
end
