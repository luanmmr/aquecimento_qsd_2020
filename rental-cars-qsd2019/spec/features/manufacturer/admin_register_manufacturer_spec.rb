require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
    expect(page).to have_content('Fabricante criada com sucesso!')
  end

  scenario 'and must fill in all fields' do
    user = create(:user)

    login_as(user, scope: :user)
    visit cars_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros '\
                                 'para continuar')
    expect(page).to have_content('Nome não pode ficar em branco')
  end

  scenario 'name must be unique' do
    manufacuter = create(:manufacturer)
    user = create(:user)

    login_as(user, scope: :user)
    visit cars_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para '\
                                 'continuar')
    expect(page).to have_content('Fabricante já cadastrada')
  end

  scenario 'with single name' do
    user = create(:user)

    login_as(user, scope: :user)
    visit cars_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'
    fill_in 'Nome', with: 'General Motors'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para '\
                                 'continuar')
    expect(page).to have_content('Nome composto ou caracteres inválidos')
  end

end
