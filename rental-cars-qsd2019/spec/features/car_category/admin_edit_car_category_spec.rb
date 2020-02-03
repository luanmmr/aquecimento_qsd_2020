require 'rails_helper'

feature 'Admin edits car category' do
  scenario 'successfully' do
    car_category = create(:car_category)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de Carros'
    within "div#car_category-#{car_category.id}" do
      click_on 'Editar'
    end
    fill_in 'Nome', with: 'B'
    fill_in 'Diária', with: 100.20
    fill_in 'Seguro do Carro', with: 58.23
    fill_in 'Seguro para Terceiros', with: 20.19
    click_on 'Enviar'

    expect(page).to have_content('Alteração realizada com sucesso')
    expect(page).to have_content('B')
    expect(page).to have_content(100.20)
    expect(page).to have_content(58.23)
    expect(page).to have_content(20.19)
  end

  scenario 'and must fill in all fields' do
    car_category = create(:car_category)
    user = create(:user)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Categorias de Carros'
    within "div#car_category-#{car_category.id}" do
      click_on 'Editar'
    end
    fill_in 'Nome', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro do Carro', with: ''
    fill_in 'Seguro para Terceiros', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para '\
                                 'continuar')
    expect(page).to have_content('O campo nome está vazio')
    expect(page).to have_content('A diária está vazia')
    expect(page).to have_content('O seguro do carro está vazio')
    expect(page).to have_content('O seguro para terceiros está vazio')
  end

  scenario 'and name must be unique' do
    car_category = create(:car_category)
    create(:car_category, name: 'W')
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias de Carros'
    within "div#car_category-#{car_category.id}" do
      click_on 'Editar'
    end
    fill_in 'Nome', with: 'W'
    click_on 'Enviar'

    expect(page).to have_content('Já existe uma categoria com este nome')
  end

  scenario 'and must be authenticated to edit a car category' do
    visit edit_car_category_path(7)

    expect(current_path).to eq(new_user_session_path)
  end
end
