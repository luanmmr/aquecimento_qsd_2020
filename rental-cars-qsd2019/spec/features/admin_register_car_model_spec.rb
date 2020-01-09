require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Registrar modelo de carro'

    fill_in 'Nome', with: 'Fiesta'
    fill_in 'Ano', with: '2020'
    fill_in 'Motorização', with: '1.8'
    fill_in 'Tipo de Combustível', with: 'Gasolina'

    click_on 'Enviar'

    expect(page).to have_content('Modelo de carro criado com sucesso!')
    expect(page).to have_content('Fiesta')
    expect(page).to have_content('2020')
    expect(page).to have_content('1.8')
    expect(page).to have_content('Gasolina')
  end

  scenario 'and must fill in all fields' do
    visit new_car_model_path

    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('O campo nome está vazio')
    expect(page).to have_content('Preencha o campo Ano')
    expect(page).to have_content('Você deve informar a Motorização')
    expect(page).to have_content('Ops, você se esqueceu do Tipo de Combustível')
  end

  scenario 'name must be unique' do
    CarModel.create!(name: 'Uno', year: '2020', motorization: '1.5', fuel_type: 'flex')

    visit new_car_model_path

    fill_in 'Nome', with: 'Uno'
    click_on 'Enviar'

    expect(page).to have_content('Este modelo de carro já existe')

  end
end
