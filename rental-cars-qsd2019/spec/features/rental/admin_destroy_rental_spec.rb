require 'rails_helper'

feature 'Admin destroys rental' do
  scenario 'successfully' do
    user = create(:user, email: 'pedro@gmail.com', password: '123456')
    create(:rental)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'XFB0000'
    click_on 'Deletar'

    expect(page).to have_content('Locação deletada com sucesso')
  end
end
