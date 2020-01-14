require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do

    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Aeroporto Congonhas'
    fill_in 'Endereço', with: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP'
    fill_in 'CNPJ', with: '28179836000114'

    click_on 'Enviar'

    expect(page).to have_content('Filial Aeroporto Congonhas')
    expect(page).to have_content('Cadastrada com sucesso!')
  end

  scenario 'and must fill in all fields' do

    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'CNPJ', with: ''

    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('O campo nome deve ser preenchido')
    expect(page).to have_content('O campo endereço deve ser preenchido')
    expect(page).to have_content('O campo CNPJ deve ser preenchido')
  end

  scenario 'name must be unique' do

    Subsidiary.create(name: 'Aeroporto Congonhas',
      address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP',
      cnpj: '28179836000114')

      user = User.create!(email: 'test#@test.com', password: '123456')

      login_as(user, scope: :user)
      visit root_path
      click_on 'Filiais'
      click_on 'Registrar nova filial'

      fill_in 'Nome', with: 'Aeroporto Congonhas'
      fill_in 'Endereço', with: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP'
      fill_in 'CNPJ', with: '28179836000114'

      click_on 'Enviar'

      expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
      expect(page).to have_content('Já há uma filial cadastrada nesse endereço')
    end

    scenario 'and cnpj must have 14 digits (-)' do

      user = User.create!(email: 'test#@test.com', password: '123456')

      login_as(user, scope: :user)
      visit new_subsidiary_path

      fill_in 'Nome', with: 'Aeroporto Congonhas'
      fill_in 'Endereço', with: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP'
      fill_in 'CNPJ', with: '2817983600011'

      click_on 'Enviar'

      expect(page).to have_content('O CNPJ deve ter 14 números')
    end

    scenario 'and cnpj must have 14 digits (+)' do

      user = User.create!(email: 'test#@test.com', password: '123456')

      login_as(user, scope: :user)
      visit new_subsidiary_path

      fill_in 'Nome', with: 'Aeroporto Congonhas'
      fill_in 'Endereço', with: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP'
      fill_in 'CNPJ', with: '281798360001141'

      click_on 'Enviar'

      expect(page).to have_content('O CNPJ deve ter 14 números')
    end

    scenario 'and must be authenticated' do

      visit new_subsidiary_path

      expect(current_path).to eq(new_user_session_path)
      
    end

  end
