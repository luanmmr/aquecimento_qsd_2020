require 'rails_helper'

feature 'Admin view Car Categories' do
  scenario 'successfully' do
    CarCategory.create(name: 'A', daily_rate: '72.20', car_insurance: '28.00', third_party_insurance: '10.00')
    CarCategory.create(name: 'B', daily_rate: '92.20', car_insurance: '35.20', third_party_insurance: '10.00')

    visit root_path
    click_on 'Categorias de Carros'

    expect(page).to have_content('A')
    expect(page).to have_content('B')
    expect(page).to have_content('Home Page')
  end

  scenario 'and return to home page' do
    CarCategory.create(name: 'A', daily_rate: '72.20', car_insurance: '28.00', third_party_insurance: '10.00')
    CarCategory.create(name: 'B', daily_rate: '92.20', car_insurance: '35.20', third_party_insurance: '10.00')

    visit root_path
    click_on 'Categorias de Carros'
    click_on 'Home Page'

    expect(current_path).to eq root_path
  end

end