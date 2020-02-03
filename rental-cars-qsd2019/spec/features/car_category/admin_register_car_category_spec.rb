require 'rails_helper'

feature 'Admin register car category' do
  scenario 'successfully' do
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Registrar nova categoria'
    fill_in 'Nome', with: 'A'
    fill_in 'Diária', with: 71.73
    fill_in 'Seguro do Carro', with: 28.00
    fill_in 'Seguro para Terceiros', with: 10.00
    click_on 'Enviar'

    expect(page).to have_content('Categoria: A')
    expect(page).to have_content('Cadastrada com sucesso')
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Registrar nova categoria'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para '\
                                 'continuar')
    expect(page).to have_content('O campo nome está vazio')
    expect(page).to have_content('A diária está vazia')
    expect(page).to have_content('O seguro do carro está vazio')
    expect(page).to have_content('O seguro para terceiros está vazio')
  end

  scenario 'name must be unique' do
    CarCategory.create(name: 'A', daily_rate: 72.20, car_insurance: 28.00,
                       third_party_insurance: 10)
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Registrar nova categoria'
    fill_in 'Nome', with: 'A'
    click_on 'Enviar'

    expect(page).to have_content('Já existe uma categoria com este nome')
  end


  scenario 'and must be authenticated' do
    visit new_car_category_path

    expect(current_path).to eq(new_user_session_path)
  end
end
