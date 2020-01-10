require 'rails_helper'

feature 'Admin destroys car category' do
  scenario 'successfully' do

    car_category = CarCategory.create(name: 'A', daily_rate: 120.00, car_insurance: 40.50, third_party_insurance: 15)

    visit car_category_path(car_category)
    click_on 'Deletar'

    expect(page).to have_content('Categoria de carro deletada com sucesso')

  end
end
