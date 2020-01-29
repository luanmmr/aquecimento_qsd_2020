require 'rails_helper'

describe 'Rental Management', type: :request do

  context '#create' do
    it 'should create rental' do
      user = User.create!(email: 'teste@teste.com.br', password: '123456')
      client = Client.create!(name: 'Jose', document: '25498763123',
                              email: 'jose@jose.com.br')
      car_category = CarCategory.create!(name: 'A', daily_rate: '72.20',
                                        car_insurance: '28.00',
                                        third_party_insurance: '10.00')

      post api_v1_rentals_path, params: {code: '12a120c4c7',
                                        start_date: Date.current,
                                        end_date: 2.days.from_now,
                                        client_id: client.id, user_id: user.id,
                                        car_category_id: car_category.id}
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json[:code]).to eq('12a120c4c7')
      expect(json[:start_date]).to eq(Date.current.strftime("%Y-%m-%d"))
      expect(json[:end_date]).to eq(2.days.from_now.strftime("%Y-%m-%d"))
      expect(json[:client_id]).to eq(client.id)
      expect(json[:user_id]).to eq(user.id)
      expect(json[:car_category_id]).to eq(car_category.id)
    end

    it 'should fail to create a rental with invalid datas' do
      post api_v1_rentals_path, params: {}
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(412)
      expect(json[:client]).to include('must exist')
      expect(json[:car_category]).to include('must exist')
      expect(json[:user]).to include('must exist')
      expect(json[:start_date]).to include('Você deve informar uma data de início')
      expect(json[:end_date]).to include('Não foi informado a data de fim')
    end
  end

end
