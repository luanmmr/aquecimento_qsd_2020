require 'rails_helper'

feature 'Admin view Car Models' do
  scenario 'successfully' do
    
    manufacturer = Manufacturer.create(name: 'Fiat')
    car_category = CarCategory.create(name: 'A', daily_rate: 120.00, car_insurance: 40.50, third_party_insurance: 15)
    CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex', car_category_id: car_category.id, manufacturer_id: manufacturer.id)

    visit root_path
    click_on 'Modelos de Carros'

    expect(page).to have_content('Uno')
    expect(page).to have_content('Home Page')
  end

  scenario 'and return to home page' do
    manufacturer = Manufacturer.create(name: 'Fiat')
    car_category = CarCategory.create(name: 'A', daily_rate: 120.00, car_insurance: 40.50, third_party_insurance: 15)
    CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex', car_category_id: car_category.id, manufacturer_id: manufacturer.id)

    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Home Page'

    expect(current_path).to eq root_path

  end
end
