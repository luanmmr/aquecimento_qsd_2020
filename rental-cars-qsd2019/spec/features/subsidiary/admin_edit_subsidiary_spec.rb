require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do
    subsidiary = create(:subsidiary)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    within "div#subsidiary-#{subsidiary.id}" do
      click_on 'Editar'
    end
    fill_in 'Nome', with: 'Interlagos'
    fill_in 'Endereço', with: 'Av Interlagos'
    fill_in 'CNPJ', with: '36232196000197'
    fill_in 'CEP', with: '04777000'
    fill_in 'Número', with: '5800'
    fill_in 'Bairro', with: 'Marajoara'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    click_on 'Enviar'

    expect(page).to have_content('Interlagos')
    expect(page).to have_content('Av Interlagos')
    expect(page).to have_content('36232196000197')
    expect(page).to have_content('04777000')
    expect(page).to have_content('5800')
    expect(page).to have_content('Marajoara')
  end

  scenario 'and must fill in all fields' do
    subsidiary = create(:subsidiary)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    within "div#subsidiary-#{subsidiary.id}" do
      click_on 'Editar'
    end
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Número', with: ''
    fill_in 'Bairro', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Estado', with: ''
    fill_in 'Cidade', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('O campo nome deve ser preenchido')
    expect(page).to have_content('O campo endereço deve ser preenchido')
    expect(page).to have_content('O campo CNPJ deve ser preenchido')
    expect(page).to have_content('O CEP deve ser informado')
    expect(page).to have_content('O número deve ser informado')
    expect(page).to have_content('Informe o bairro')
    expect(page).to have_content('O estado não foi informado')
    expect(page).to have_content('A cidade não foi informada')
  end

  scenario 'and zip_code and number must be unique' do
    subsidiary = create(:subsidiary)
    other_subsidiary = create(:subsidiary, name: 'Moema', zip_code: '04077020',
                              number: 1884)
    user = create(:user)

    login_as(user, :scope => :user)
    visit root_path
    click_on 'Filiais'
    within "div#subsidiary-#{other_subsidiary.id}" do
      click_on 'Editar'
    end
    fill_in 'CEP', with: '05724030'
    fill_in 'Número', with: 50
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('Essa filial já existe')
  end

  scenario 'and must be authenticated' do
    visit edit_car_category_path(7)

    expect(current_path).to eq(new_user_session_path)
  end

end
