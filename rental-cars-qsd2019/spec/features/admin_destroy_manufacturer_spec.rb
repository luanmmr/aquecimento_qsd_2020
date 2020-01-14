require 'rails_helper'

feature 'Admin destroys manufacturer' do
  scenario 'successfully' do

    manufacturer = Manufacturer.create!(name: 'Fiat')
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit manufacturer_path(manufacturer)
    click_on 'Deletar'

    expect(page).to have_content('Fábrica deletada com sucesso')

  end
end
