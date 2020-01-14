require 'rails_helper'

feature 'Admin register car category' do
  scenario 'successfully' do

    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Registrar nova categoria de carro'

    fill_in 'Nome', with: 'A'
    fill_in 'Diária', with: 71.73
    fill_in 'Seguro do Carro', with: 28.00
    fill_in 'Seguro para Terceiros', with: 10.00

    click_on 'Enviar'

    expect(page).to have_content('Categoria A')
    expect(page).to have_content('Cadastrada com sucesso')
  end

  scenario 'and must fill in all fields' do

    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Registrar nova categoria de carro'

    fill_in 'Nome', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro do Carro', with: ''
    fill_in 'Seguro para Terceiros', with: ''

    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('O campo nome está vazio')
    expect(page).to have_content('A diária está vazia')
    expect(page).to have_content('O seguro do carro está vazio')
    expect(page).to have_content('O seguro para terceiros está vazio')
  end

  scenario 'name must be unique' do

    CarCategory.create(name: 'A', daily_rate: 72.20, car_insurance: 28.00, third_party_insurance: 10)
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Registrar nova categoria de carro'

    fill_in 'Nome', with: 'A'

    click_on 'Enviar'

    expect(page).to have_content('Já existe uma categoria com este nome')
  end

  scenario 'and the fields daily rate, car insurance and third party insurance must be a number' do

    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit new_car_category_path

    fill_in 'Nome', with: 'A'
    fill_in 'Diária', with: 'teste'
    fill_in 'Seguro do Carro', with: 0
    fill_in 'Seguro para Terceiros', with: 0

    click_on 'Enviar'

    expect(page).to have_content('Campo diária com valor inválido')
    expect(page).to have_content('Campo seguro do carro com valor inválido')
    expect(page).to have_content('Campo seguro para terceiros com valor inválido')

  end

  scenario 'and must be authenticated' do

    visit new_car_category_path

    expect(current_path).to eq(new_user_session_path)

  end


end
