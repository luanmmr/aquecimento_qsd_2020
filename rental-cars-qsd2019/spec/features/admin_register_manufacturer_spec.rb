require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do

    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
    expect(page).to have_content('Fabricante criada com sucesso!')

  end

  scenario 'and must fill in all fields' do

    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('Nome não pode ficar em branco')

  end

  scenario 'name must be unique' do

    # Create com bang - create! - lança uma exceção caso o argumento seja passado de maneira errada
    # Assim saberei que houve um erro logo na criação
    # Caso não coloque e o argumento seja passado de maneira errada, será difícil a identificação da
    # origem da faha
    Manufacturer.create!(name: 'Honda')
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('Fabricante já cadastrada')

  end

  scenario 'with single name' do

    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit new_manufacturer_path
    fill_in 'Nome', with: 'General Motors'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar:')
    expect(page).to have_content('Nome composto ou caracteres inválidos')

  end

  scenario 'and must be authenticated' do

    visit new_car_category_path

    expect(current_path).to eq(new_user_session_path)

  end


end
