require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    manufacturer = Manufacturer.create(name: 'Fiat')
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    within("div#manufacturer-#{manufacturer.id}") do
      click_on 'Editar'
    end
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Fábrica editada com sucesso!')
    expect(page).to have_content('Honda')
  end

  scenario 'and must fill in all fields' do
    manufacturer = Manufacturer.create(name: 'Fiat')
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    within("div#manufacturer-#{manufacturer.id}") do
      click_on 'Editar'
    end
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and name must be unique' do
    manufacturer = Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Honda')
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Fabricantes'
    within("div#manufacturer-#{manufacturer.id}") do
      click_on 'Editar'
    end
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('Fabricante já cadastrada')
  end

  scenario 'with single name' do

    manufacturer = Manufacturer.create(name: 'Ford')
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit manufacturers_path
    within("div#manufacturer-#{manufacturer.id}") do
      click_on 'Editar'
    end
    fill_in 'Nome', with: 'Fabricante Ford'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('Nome composto ou caracteres inválidos')

  end

  scenario 'and must be authenticated' do

    visit edit_car_category_path(7)

    expect(current_path).to eq(new_user_session_path)

  end

end
