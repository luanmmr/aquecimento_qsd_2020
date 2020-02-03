require 'rails_helper'

feature 'Admin view Car Models' do
  scenario 'successfully' do
    create(:car_model)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Modelos de Carros'

    expect(page).to have_content('Uno')
    expect(page).to have_content('Fiat')
  end

  scenario 'and return to home page' do
    create(:car_model)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Modelos de Carros'
    click_on 'Home Page'

    expect(current_path).to eq root_path
  end
end
