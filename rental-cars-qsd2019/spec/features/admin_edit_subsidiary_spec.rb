require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do
    Subsidiary.create(name: 'Aeroporto Congonhas',
      address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP',
      cnpj: '28179836000114')

      user = User.create!(email: 'test#@test.com', password: '123456')
      login_as(user, :scope => :user)

      visit root_path
      click_on 'Filiais'
      click_on 'Aeroporto Congonhas'
      click_on 'Editar'

      fill_in 'Nome', with: 'Carrefour Giovanni'
      fill_in 'Endereço', with: 'Av Alberto Augusto Alves, 50, Vila Andrade, SP'
      fill_in 'CNPJ', with: '16468498000151'
      click_on 'Enviar'

      expect(page).to have_content('Carrefour Giovanni')
      expect(page).to have_content('Av Alberto Augusto Alves, 50, Vila Andrade, SP')
      expect(page).to have_content('16468498000151')
    end

    scenario 'and must fill in all fields' do
      Subsidiary.create(name: 'Aeroporto Congonhas',
        address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP',
        cnpj: '28179836000114')

        user = User.create!(email: 'test#@test.com', password: '123456')
        login_as(user, :scope => :user)

        visit root_path
        click_on 'Filiais'
        click_on 'Aeroporto Congonhas'
        click_on 'Editar'

        fill_in 'Nome', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'CNPJ', with: ''

        click_on 'Enviar'

        expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
        expect(page).to have_content('O campo nome deve ser preenchido')
        expect(page).to have_content('O campo endereço deve ser preenchido')
        expect(page).to have_content('O campo CNPJ deve ser preenchido')
      end

      scenario 'and name must be unique' do

        Subsidiary.create(name: 'Aeroporto Congonhas',
          address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP',
          cnpj: '28179836000114')

          Subsidiary.create(name: 'Carrefour Giovanni',
            address: 'Av Alberto Augusto Alves, 50, Vila Andrade, SP',
            cnpj: '28179836000114')

            user = User.create!(email: 'test#@test.com', password: '123456')
            login_as(user, :scope => :user)

            visit root_path
            click_on 'Filiais'
            click_on 'Aeroporto Congonhas'
            click_on 'Editar'

            fill_in 'Nome', with: 'Carrefour Giovanni'
            fill_in 'Endereço', with: 'Av Alberto Augusto Alves, 50, Vila Andrade, SP'
            fill_in 'CNPJ', with: '28179836000114'
            click_on 'Enviar'

            expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
            expect(page).to have_content('Já há uma filial cadastrada nesse endereço')
          end


          scenario 'and cnpj must have 14 digits (-)' do

            subsidiary = Subsidiary.create(name: 'Aeroporto Congonhas',
              address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP',
              cnpj: '28179836000114')

              user = User.create!(email: 'test#@test.com', password: '123456')
              login_as(user, :scope => :user)

              visit edit_subsidiary_path(subsidiary)

              fill_in 'Nome', with: 'Aeroporto Congonhas'
              fill_in 'Endereço', with: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP'
              fill_in 'CNPJ', with: '2817983600011'

              click_on 'Enviar'

              expect(page).to have_content('O CNPJ deve ter 14 números')
            end

            scenario 'and cnpj must have 14 digits (+)' do

              subsidiary = Subsidiary.create(name: 'Aeroporto Congonhas',
                address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP',
                cnpj: '28179836000114')

                user = User.create!(email: 'test#@test.com', password: '123456')
                login_as(user, :scope => :user)
                
                visit edit_subsidiary_path(subsidiary)

                fill_in 'Nome', with: 'Aeroporto Congonhas'
                fill_in 'Endereço', with: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP'
                fill_in 'CNPJ', with: '281798360001141'

                click_on 'Enviar'

                expect(page).to have_content('O CNPJ deve ter 14 números')
              end

            end
