require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    # Testes de três estados - AAA

    # Arrange - Criar dados
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')
    user = User.create!(email: 'test#@test.com', password: '123456')

    # Act - Executar ações
    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'

    # Assert - Verificar coisas
    expect(page).to have_content('Fiat')
  end

  scenario 'and return to home page' do
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Home Page'

    expect(current_path).to eq root_path
  end

  scenario 'and must be authenticated' do
    visit manufacturers_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated for more view show' do
    visit manufacturer_path(17)

    expect(current_path).to eq(new_user_session_path)
  end
end
