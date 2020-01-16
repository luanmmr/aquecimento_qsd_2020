require 'rails_helper'

feature 'User schedule rental' do
  scenario 'successfully' do

    car_category =  CarCategory.create!(name: 'A', daily_rate: 72.20, car_insurance: 28.00, third_party_insurance: 10.00)
    client = Client.create!(name: 'Fulano', document: '2938248684', email: 'fulano@test.com')
    user = User.create!(email: 'teste@hotmail.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'

    fill_in 'Data de início', with: '15/01/2020'
    fill_in 'Data de fim', with: '17/01/2020'
    select 'Fulano', from: 'Cliente'
    select 'A', from: 'Categoria de Carro'
    click_on 'Enviar'

    expect(page).to have_content('Locação agendada com sucesso')
    expect(page).to have_content('15/01/2020')
    expect(page).to have_content('17/01/2020')
    expect(page).to have_content('Fulano')
    expect(page).to have_content(/A/)
    expect(page).to have_content('teste@hotmail.com')

  end
end
