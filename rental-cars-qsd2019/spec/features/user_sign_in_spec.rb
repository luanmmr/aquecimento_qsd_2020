require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    User.create!(email: 'test@test.com', password: '123456')

    visit root_path
    click_on 'Entrar'

    within 'form' do
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_link('Sair')
    expect(page).not_to have_link('Entrar')
    expect(current_path).to eq(root_path)

  end

  scenario 'and logout successfully' do
    User.create!(email: 'test@test.com', password: '123456')

    visit root_path
    click_on 'Entrar'

    within 'form' do
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Sair'

    expect(page).to have_content('Signed out successfully')
    expect(current_path).to eq(root_path)


  end
end
