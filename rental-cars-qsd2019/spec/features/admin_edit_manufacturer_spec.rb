require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    Manufacturer.create(name: 'Fiat')

    user = User.create!(email: 'test#@test.com', password: '123456')
    login_as(user, :scope => :user)

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'

    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Fábrica editada com sucesso!')
    expect(page).to have_content('Honda')
  end

  scenario 'and must fill in all fields' do
    Manufacturer.create(name: 'Fiat')

    user = User.create!(email: 'test#@test.com', password: '123456')
    login_as(user, :scope => :user)

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'and name must be unique' do
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Honda')

    user = User.create!(email: 'test#@test.com', password: '123456')
    login_as(user, :scope => :user)

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'

    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('Fabricante já cadastrada')
  end

  scenario 'with single name' do
    Manufacturer.create(name: 'Ford')

    user = User.create!(email: 'test#@test.com', password: '123456')
    login_as(user, :scope => :user)

    visit manufacturers_path
    click_on 'Ford'
    click_on 'Editar'

    fill_in 'Nome', with: 'Fabricante Ford'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('Nome composto ou caracteres inválidos')

  end
end
