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

  scenario 'and cpf must be unique' do
    user = User.create!(email: 'teste@hotmail.com', password: '123456')
    Client.create!(name: 'Jose', document: '25498763123', email: 'jose@jose.com.br')

    login_as(user, scope: :user)
    visit new_client_path
    fill_in 'Nome', with: 'Jose'
    fill_in 'CPF', with: '25498763123'
    fill_in 'Email', with: 'jose@jose.com.br'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('Esse cliente já está cadastrado no sistema')
  end

  scenario 'and name must to have only words' do
    user = User.create!(email: 'teste@hotmail.com', password: '123456')

    login_as(user, scope: :user)
    visit new_client_path
    fill_in 'Nome', with: 'Jos3 5ilva'
    click_on 'Enviar'

    expect(page).to have_content('Nome inválido')

    fill_in 'Nome', with: 'Jos_ S#ilva'

    expect(page).to have_content('Nome inválido')
  end

  scenario 'and cpf must have only numbers' do
    
    user = User.create!(email: 'teste@hotmail.com', password: '123456')

    login_as(user, scope: :user)
    visit new_client_path
    fill_in 'CPF', with: 'testetestet'
    click_on 'Enviar'

    expect(page).to have_content('O CPF deve conter apenas números')


  end
end
