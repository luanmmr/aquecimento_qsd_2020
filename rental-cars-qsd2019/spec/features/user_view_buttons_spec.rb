require 'rails_helper'

feature 'User view buttons' do
  scenario 'authenticated' do

    visit root_path

    expect(page).not_to have_link('Fabricantes')
    expect(page).not_to have_link('Filiais')
    expect(page).not_to have_link('Categorias de Carros')
    expect(page).not_to have_link('Modelos de Carros')
    expect(page).not_to have_link('Clientes')
    expect(page).not_to have_link('Locações')
    expect(page).not_to have_content('Olá')

  end
end
