require 'rails_helper'

feature 'User search rental' do
  scenario 'by exact code' do

    car_category =  CarCategory.create!(name: 'A', daily_rate: 72.20, car_insurance: 28.00, third_party_insurance: 10.00)
    client = Client.create!(name: 'Fulano', document: '2938248684', email: 'fulano@test.com')

    Rental.create!(code: 'XFB0000', start_date: Date.current,
      end_date: 1.day.from_now,
      client: client, car_category: car_category)

    Rental.create!(code: 'XFB0001', start_date: Date.current,
      end_date: 1.day.from_now,
      client: client, car_category: car_category)

    Rental.create!(code: 'XFB0000', start_date: Date.current,
      end_date: 1.day.from_now,
      client: client, car_category: car_category)

    user = User.create!(email: 'teste@hotmail.com', password: '123456')

    login_as(user, scopo: :user)
    visit root_path
    click_on 'Locações'

    within 'form' do
    fill_in 'Pesquisa', with: 'XFB0000'
    click_on 'Buscar'
    end

    expect(page).to have_content('XFB0000')
    expect(page).to have_content('Fulano')
    expect(page).to have_content('fulano@test.com')
    expect(page).to have_content('2 resultado(s) encontrado(s)')
    expect(page).to_not have_content('XFB0001')

    end

    scenario 'and not found' do

      car_category =  CarCategory.create!(name: 'A', daily_rate: 72.20, car_insurance: 28.00, third_party_insurance: 10.00)
      client = Client.create!(name: 'Fulano', document: '2938248684', email: 'fulano@test.com')

      Rental.create!(code: 'XFB0000', start_date: Date.current,
        end_date: 1.day.from_now,
        client: client, car_category: car_category)


      user = User.create!(email: 'teste@hotmail.com', password: '123456')

      login_as(user, scopo: :user)
      visit root_path
      click_on 'Locações'

      within 'form' do
      fill_in 'Pesquisa', with: 'XFB0001'
      click_on 'Buscar'
      end

      expect(page).to have_content('0 resultado(s) encontrado(s)')
      expect(page).to_not have_content('XFB0000')

    end
  end
