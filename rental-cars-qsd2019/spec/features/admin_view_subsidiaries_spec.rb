require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create(name: 'Aeroporto Congonhas',
      address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP',
      cnpj: '28179836000114')

      visit root_path
      click_on 'Filiais'
      click_on 'Aeroporto Congonhas'

      expect(page).to have_content('Aeroporto Congonhas')
      expect(page).to have_content('Home Page')
    end

    scenario 'and return to home page' do
      Subsidiary.create(name: 'Aeroporto Congonhas',
        address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP',
        cnpj: '28179836000114')

        visit root_path
        click_on 'Filiais'
        click_on 'Aeroporto Congonhas'
        click_on 'Home Page'

        expect(current_path).to eq root_path
      end

    end
