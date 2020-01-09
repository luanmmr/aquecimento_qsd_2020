require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    # Testes de três estados - AAA

    # Arrange - Criar dados
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')

    # Act - Executar ações
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'

    # Assert - Verificar coisas
    expect(page).to have_content('Fiat')
    expect(page).to have_link('Home Page')
  end

  scenario 'and return to home page' do
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Home Page'

    expect(current_path).to eq root_path
  end
end
