require 'rails_helper'

feature 'Admin view Car Models' do
  scenario 'successfully' do

    manufacturer = Manufacturer.create(name: 'Fiat')
    car_category = CarCategory.create(name: 'A', daily_rate: 120.00, car_insurance: 40.50,
                                      third_party_insurance: 15)
    CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                     car_category: car_category, manufacturer: manufacturer)
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de Carros'

    expect(page).to have_content('Uno')
    expect(page).to have_content('Home Page')
  end

  scenario 'and return to home page' do

    manufacturer = Manufacturer.create(name: 'Fiat')
    car_category = CarCategory.create(name: 'A', daily_rate: 120.00, car_insurance: 40.50,
                                      third_party_insurance: 15)
    CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                     car_category: car_category, manufacturer: manufacturer)
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de Carros'
    click_on 'Home Page'

    expect(current_path).to eq root_path

  end

  scenario 'and must be authenticated' do

    visit car_models_path

    expect(current_path).to eq(new_user_session_path)

  end

  scenario 'and must be authenticated for more view show' do

    visit car_model_path(17)

    expect(current_path).to eq(new_user_session_path)

  end
end
