require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    create(:manufacturer)
    create(:car_category)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Modelos de Carros'
    click_on 'Registrar novo modelo de carro'
    fill_in 'Nome', with: 'Cronos'
    fill_in 'Ano', with: '2020'
    fill_in 'Motor', with: '1.8'
    fill_in 'Combustível', with: 'Gasolina'
    select 'Fiat', from: 'Fabricante'
    select 'X', from: 'Categoria do Carro'
    click_on 'Enviar'

    expect(page).to have_content('Modelo de carro criado com sucesso!')
    expect(page).to have_content('Cronos')
    expect(page).to have_content('2020')
    expect(page).to have_content('1.8')
    expect(page).to have_content('Gasolina')
    expect(page).to have_content('Fiat')
    expect(page).to have_content(/X/)
  end

  scenario 'and must fill in all fields' do
    user = create(:user)

    login_as(user, scope: :user)
    visit new_car_model_path
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para '\
                                 'continuar')
    expect(page).to have_content('O campo nome está vazio')
    expect(page).to have_content('Preencha o campo ano')
    expect(page).to have_content('Você deve informar a motorização')
    expect(page).to have_content('Ops, você se esqueceu do tipo de combustível')
  end

  scenario 'name must be unique' do
    user = create(:user)
    create(:car_model)

    login_as(user, scope: :user)
    visit new_car_model_path
    fill_in 'Nome', with: 'Uno'
    fill_in 'Ano', with: '2018'
    fill_in 'Motor', with: '1.8'
    fill_in 'Combustível', with: 'Flex'
    click_on 'Enviar'

    expect(page).to have_content('Este modelo de carro já existe nesta '\
                                 'categoria')
  end

end
