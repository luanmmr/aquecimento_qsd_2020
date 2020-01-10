require 'rails_helper'

feature 'Admin destroys subsidiary' do
  scenario 'successfully' do

    subsidiary = Subsidiary.create(name: 'Fiat', cnpj: '12345678912345', address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP')

    visit subsidiary_path(subsidiary)
    click_on 'Deletar'

    expect(page).to have_content('Filial deletada com sucesso')

  end
end
