require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'
    fill_in 'Nome', with: 'Interlagos'
    fill_in 'CNPJ', with: '28179836000114'
    fill_in 'Endereço', with: 'Av Interlagos'
    fill_in 'Número', with: 52
    fill_in 'Bairro', with: 'Interlagos'
    fill_in 'Estado', with: 'SP'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'CEP', with: '04661902'
    click_on 'Enviar'

    expect(page).to have_content('Interlagos')
    expect(page).to have_content('Cadastrada com sucesso!')
  end

  scenario 'and must fill in all fields' do
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'
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
    create(:subsidiary)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'
    fill_in 'Número', with: 50
    fill_in 'CEP', with: '05724030'
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros para continuar')
    expect(page).to have_content('Essa filial já existe')
  end

  scenario 'and must be authenticated' do
    visit new_subsidiary_path

    expect(current_path).to eq(new_user_session_path)
  end

end
