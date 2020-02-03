require 'rails_helper'

feature 'Admin edits car model' do
  scenario 'successfully' do
    create(:manufacturer, name: 'Honda')
    create(:car_category, name: 'B')
    car_model = create(:car_model)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Modelos de Carros'
    within "td#car_model-#{car_model.id}" do
      click_on 'Editar'
    end
    fill_in 'Nome', with: 'Fit'
    fill_in 'Ano', with: '2020'
    fill_in 'Motor', with: '1.8'
    fill_in 'Combustível', with: 'Gasolina'
    select 'Honda', from: 'Fabricante'
    select 'B', from: 'Categoria do Carro'
    click_on 'Enviar'

    expect(page).to have_content('Modelo de carro editado com sucesso!')
    expect(page).to have_content('Fit')
    expect(page).to have_content('2020')
    expect(page).to have_content('1.8')
    expect(page).to have_content('Gasolina')
    expect(page).to have_content('Honda')
    expect(page).to have_content(/B/)
  end

  scenario 'and must fill in all fields' do
    car_model = create(:car_model)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Modelos de Carros'
    within "td#car_model-#{car_model.id}" do
      click_on 'Editar'
    end
    fill_in 'Nome', with: ''
    fill_in 'Ano', with: ''
    fill_in 'Motor', with: ''
    fill_in 'Combustível', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('O campo nome está vazio')
    expect(page).to have_content('Preencha o campo ano')
    expect(page).to have_content('Você deve informar a motorização')
    expect(page).to have_content('Ops, você se esqueceu do tipo de combustível')
  end

  scenario 'and name must be unique' do
    user = create(:user)
    car_model = create(:car_model)
    manufacturer = create(:manufacturer, name: 'Honda')
    car_category = create(:car_category, name: 'W', daily_rate: 129.00,
                          car_insurance: 30.00, third_party_insurance: 30.00)
    other_car_model = create(:car_model, manufacturer: manufacturer,
                             car_category: car_category, name: 'Fit',
                             year: '2019', motorization: '1.8',
                             fuel_type: 'Flex')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros'
    click_on 'Modelos de Carros'
    within "td#car_model-#{car_model.id}" do
      click_on 'Editar'
    end
    fill_in 'Nome', with: 'Fit'
    fill_in 'Ano', with: '2019'
    fill_in 'Combustível', with: 'Flex'
    fill_in 'Motor', with: '1.8'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para '\
                                 'continuar')
    expect(page).to have_content('Este modelo de carro já existe nesta '\
                                 'categoria')
  end

  scenario 'and must be authenticated' do
    visit edit_car_category_path(7)

    expect(current_path).to eq(new_user_session_path)
  end

end
