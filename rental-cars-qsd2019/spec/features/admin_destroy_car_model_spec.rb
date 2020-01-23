require 'rails_helper'

feature 'Admin destroys manufacturer' do
  scenario 'successfully' do

    manufacturer = Manufacturer.create(name: 'Fiat')
    car_category = CarCategory.create(name: 'B', daily_rate: 120.00, car_insurance: 40.50, third_party_insurance: 15)
    car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex', car_category: car_category, manufacturer: manufacturer)
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit car_model_path(car_model)
    click_on 'Deletar'

    expect(page).to have_content('Modelo de carro deletado com sucesso')
    
  end
end
