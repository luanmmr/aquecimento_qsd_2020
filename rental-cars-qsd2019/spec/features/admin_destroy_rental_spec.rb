require 'rails_helper'

feature 'Admin destroys rental' do
  scenario 'successfully' do

    user = User.create!(email: 'test#@test.com', password: '123456')
    client = Client.create!(name: 'Jose', document: '25498763123', email: 'jose@jose.com.br')
    car_category = CarCategory.create(name: 'A', daily_rate: '72.20', car_insurance: '28.00', third_party_insurance: '10.00')
    rental  = Rental.create!(code: '12a120c4c7', start_date: '02/01/2020', end_date: '02/03/2020', client: client, car_category: car_category, user: user)

    login_as(user, scope: :user)
    visit rental_path(rental)
    click_on 'Deletar'

    expect(page).to have_content('Locação deletada com sucesso')

  end
end
