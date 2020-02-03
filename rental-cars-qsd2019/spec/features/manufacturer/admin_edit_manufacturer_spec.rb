require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    manufacturer = create(:manufacturer)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
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
    manufacturer = create(:manufacturer)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
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
    create(:manufacturer, name: 'Honda')
    manufacturer = create(:manufacturer)
    user = create(:user)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Carros'
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
    manufacturer = create(:manufacturer)
    user = create(:user)

    login_as(user, scope: :user)
    visit cars_path
    click_on 'Fabricantes'
    within("div#manufacturer-#{manufacturer.id}") do
      click_on 'Editar'
    end
    fill_in 'Nome', with: 'Fabricante Ford'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('Nome composto ou caracteres inválidos')
  end

end
