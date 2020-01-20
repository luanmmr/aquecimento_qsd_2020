require 'rails_helper'

feature 'Admin destroys client' do
  scenario 'successfully' do

    client = Client.create!(name: 'Jose', document: '25498763123', email: 'jose@jose.com.br')
    user = User.create!(email: 'test#@test.com', password: '123456')

    login_as(user, scope: :user)
    visit client_path(client)
    click_on 'Deletar'

    expect(page).to have_content('Cliente deletado com sucesso')

  end
end
