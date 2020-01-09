require 'rails_helper'

feature 'Admin view Car Models' do
  scenario 'successfully' do
    CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex')

    visit root_path
    click_on 'Modelos de Carros'

    expect(page).to have_content('Uno')
    expect(page).to have_content('Home Page')
  end

  scenario 'and return to home page' do
    CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex')

    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Home Page'

    expect(current_path).to eq root_path

  end
end
