require 'rails_helper'

feature 'Admin edits car model' do
  scenario 'successfully' do

    manufacturer = Manufacturer.create(name: 'Fiat')
    car_category = CarCategory.create(name: 'A', daily_rate: 120.00, car_insurance: 40.50, third_party_insurance: 15)
    Manufacturer.create(name: 'Honda')  
    CarCategory.create(name: 'B', daily_rate: 120.00, car_insurance: 40.50, third_party_insurance: 15)

    car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex', car_category_id: car_category.id, manufacturer_id: manufacturer.id)

    visit edit_car_model_path(car_model)

    fill_in 'Nome', with: 'Fit'
    fill_in 'Ano', with: '2020'
    fill_in 'Motorização', with: '1.8'
    fill_in 'Tipo de Combustível', with: 'Gasolina'
    select 'Honda', from: 'Fabricante'
    select 'B', from: 'Categoria do Carro'

    click_on 'Enviar'

    expect(page).to have_content('Modelo de carro editado com sucesso!')
    expect(page).to have_content('Fit')
    expect(page).to have_content('2020')
    expect(page).to have_content('1.8')
    expect(page).to have_content('Gasolina')
    expect(page).to have_content('Honda')
    expect(page).to have_content(/B/)

  end

  scenario 'and must fill in all fields' do

    manufacturer = Manufacturer.create(name: 'Fiat')
    car_category = CarCategory.create(name: 'B', daily_rate: 120.00, car_insurance: 40.50, third_party_insurance: 15)
    car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex', car_category_id: car_category.id, manufacturer_id: manufacturer.id)

    visit edit_car_model_path(car_model)

    fill_in 'Nome', with: ''
    fill_in 'Ano', with: ''
    fill_in 'Motorização', with: ''
    fill_in 'Tipo de Combustível', with: ''

    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('O campo nome está vazio')
    expect(page).to have_content('Preencha o campo ano')
    expect(page).to have_content('Você deve informar a motorização')
    expect(page).to have_content('Ops, você se esqueceu do tipo de combustível')

  end

  scenario 'and name must be unique' do

    manufacturer_fiat = Manufacturer.create(name: 'Fiat')
    car_category_a = CarCategory.create(name: 'A', daily_rate: 120.00, car_insurance: 40.50, third_party_insurance: 15)
    manufacturer_honda = Manufacturer.create(name: 'Honda')
    car_category_b = CarCategory.create(name: 'B', daily_rate: 120.00, car_insurance: 40.50, third_party_insurance: 15)

    car_model_1 = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex', car_category_id: car_category_a.id, manufacturer_id: manufacturer_fiat.id)
    car_model_2 = CarModel.create!(name: 'Fit', year: '2018', motorization: '1.5', fuel_type: 'Flex', car_category_id: car_category_b.id, manufacturer_id: manufacturer_honda.id)

    visit edit_car_model_path(car_model_1)

    fill_in 'Nome', with: 'Fit'
    fill_in 'Ano', with: '2018'
    select 'B', from: 'Categoria do Carro'

    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('Este modelo de carro já existe nesta categoria')
  end

end
