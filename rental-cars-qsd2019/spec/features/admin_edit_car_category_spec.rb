require 'rails_helper'

feature 'Admin edits car category' do
  scenario 'successfully' do

    CarCategory.create(name: 'A', daily_rate: 72.20, car_insurance: 28.00, third_party_insurance: 10.00)
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'A'
    click_on 'Editar'

    fill_in 'Nome', with: 'B'
    fill_in 'Diária', with: 100.20
    fill_in 'Seguro do Carro', with: 58.23
    fill_in 'Seguro para Terceiros', with: 20.19

    click_on 'Enviar'

    expect(page).to have_content('Alteração realizada com sucesso')
    expect(page).to have_content('B')
    expect(page).to have_content(100.20)
    expect(page).to have_content(58.23)
    expect(page).to have_content(20.19)
  end

  scenario 'and must fill in all fields' do

    CarCategory.create(name: 'A', daily_rate: 72.20, car_insurance: 28.00, third_party_insurance: 10.00)

    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'A'
    click_on 'Editar'

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

  scenario 'and name must be unique' do

    CarCategory.create(name: 'A', daily_rate: 72.20, car_insurance: 28.00, third_party_insurance: 10.00)
    CarCategory.create(name: 'B', daily_rate: 97.20, car_insurance: 35.00, third_party_insurance: 22.50)
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'A'
    click_on 'Editar'

    fill_in 'Nome', with: 'B'
    click_on 'Enviar'

    expect(page).to have_content('Já existe uma categoria com este nome')
  end

  scenario 'and the fields daily rate, car insurance and third party insurance must be a number' do

    car_category = CarCategory.create(name: 'A', daily_rate: 72.20, car_insurance: 28.00, third_party_insurance: 10.00)

    user = User.create!(email: 'test#@test.com', password: '123456')
    login_as(user, :scope => :user)

    visit edit_car_category_path(car_category)

    fill_in 'Diária', with: 'teste'
    fill_in 'Seguro do Carro', with: 0
    fill_in 'Seguro para Terceiros', with: 0

    click_on 'Enviar'

    expect(page).to have_content('Campo diária com valor inválido')
    expect(page).to have_content('Campo seguro do carro com valor inválido')
    expect(page).to have_content('Campo seguro para terceiros com valor inválido')

  end

  scenario 'and must be authenticated' do

    visit edit_car_category_path(7)

    expect(current_path).to eq(new_user_session_path)

  end
end
