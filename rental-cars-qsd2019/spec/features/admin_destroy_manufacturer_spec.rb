require 'rails_helper'

feature 'Admin destroys manufacturer' do
  scenario 'successfully' do

    manufacturer = Manufacturer.create(name: 'Fiat')

    visit manufacturer_path(manufacturer)
    click_on 'Deletar'

    expect(page).to have_content('Fábrica deletada com sucesso')

  end
end
