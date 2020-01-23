require 'rails_helper'

feature 'Admin edit client' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@hotmail.com', password: '123456')
    Client.create!(name: 'Jose', document: '25498763123', email: 'jose@jose.com.br')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Clientes'
    click_on 'Jose'
    click_on 'Editar'
    fill_in 'Nome', with: 'Maria'
    fill_in 'Email', with: 'maria@hotmail.com'
    fill_in 'CPF', with: '49582428151'
    click_on 'Enviar'

    expect(page).to have_content('Cliente editado com sucesso')
    expect(page).to have_content('Maria')
    expect(page).to have_content('maria@hotmail.com')
    expect(page).to have_content('49582428151')
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'teste@hotmail.com', password: '123456')
    client = Client.create!(name: 'Jose', document: '25498763123', email: 'jose@jose.com.br')

    login_as(user, scope: :user)
    visit edit_client_path(client)
    fill_in 'Nome', with: ''
    fill_in 'Email', with: ''
    fill_in 'CPF', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')

  end

  scenario 'and cpf must be unique' do
    user = User.create!(email: 'teste@hotmail.com', password: '123456')
    Client.create(name: 'Jose', document: '25498763123', email: 'jose@jose.com.br')
    other_client = Client.create(name: 'Maria', document: '14498169112', email: 'maria@jose.com.br')

    login_as(user, scope: :user)
    visit edit_client_path(other_client)
    fill_in 'CPF', with: '25498763123'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('Esse cliente já está cadastrado no sistema')
  end

  scenario 'and name must to have only words' do

    user = User.create!(email: 'teste@hotmail.com', password: '123456')
    client = Client.create(name: 'Jose', document: '25498763123', email: 'jose@jose.com.br')

    login_as(user, scope: :user)
    visit edit_client_path(client)
    fill_in 'Nome', with: 'P3dr0 5ilva'
    click_on 'Enviar'

    expect(page).to have_content('Nome inválido')

    fill_in 'Nome', with: 'Pedr_ S#ilva'

    expect(page).to have_content('Nome inválido')

  end

  scenario 'and cpf must have only numbers' do
    
    user = User.create!(email: 'teste@hotmail.com', password: '123456')
    client = Client.create(name: 'Jose', document: '25498763123', email: 'jose@jose.com.br')

    login_as(user, scope: :user)
    visit edit_client_path(client)
    fill_in 'CPF', with: 'testetestet'
    click_on 'Enviar'

    expect(page).to have_content('O CPF deve conter apenas números')

  end

  scenario 'and must be authenticated' do

    visit edit_client_path(7)

    expect(current_path).to eq(new_user_session_path)

  end
end
