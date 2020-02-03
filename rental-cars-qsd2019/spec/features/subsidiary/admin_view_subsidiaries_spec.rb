require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    create(:subsidiary)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Carrefour Giovanni Gronchi')
    expect(page).to have_content('41298631000116')
  end

  scenario 'and return to home page' do
    create(:subsidiary)
    user = create(:user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Carrefour Giovanni Gronchi'
    click_on 'Home Page'

    expect(current_path).to eq root_path
  end

  scenario 'and must be authenticated' do
    visit subsidiaries_path

    expect(current_path).to eq(new_user_session_path)
  end

  scenario 'and must be authenticated for more view show' do
    visit subsidiary_path(7)

    expect(current_path).to eq(new_user_session_path)
  end

end
