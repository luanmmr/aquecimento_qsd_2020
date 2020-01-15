require 'rails_helper'

feature 'User register client' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@hotmail.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Fulano Sicrano'
    fill_in 'Email', with: 'fulano@hotmail.com'
    fill_in 'CPF', with: '29382458754'
    click_on 'Enviar'

    expect(page).to have_content('Cliente registrado com sucesso')
    expect(page).to have_content('Fulano Sicrano')
    expect(page).to have_content('fulano@hotmail.com')
    expect(page).to have_content('29382458754')
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'teste@hotmail.com', password: '123456')

    login_as(user, scope: :user)
    visit new_client_path

    click_on 'Enviar'

    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')

  end
end
