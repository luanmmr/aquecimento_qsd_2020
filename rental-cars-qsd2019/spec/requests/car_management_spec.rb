require 'rails_helper'

describe 'Car Management', type: :request do

  context '#show' do
    it 'render a json of a single car successfully' do
      subsidiary = Subsidiary.create!(name: 'Av Paulista', cnpj: '28179836000114',
                                      address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP')
      car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                                   car_category: CarCategory.new, manufacturer: Manufacturer.new)
      car = Car.create!(license_plate: 'JSO1245', color: 'Azul', car_model: car_model,
                        mileage: 100, subsidiary: subsidiary)

      get api_v1_car_path(car)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json[:license_plate]).to eq('JSO1245')
      expect(json[:color]).to eq('Azul')
      expect(json[:car_model_id]).to eq(car.car_model.id)
      expect(json[:subsidiary_id]).to eq(car.subsidiary.id)
    end

    it 'cannot find object car' do
      get api_v1_car_path(id: 777)

      expect(response).to have_http_status(:not_found)
    end
  end

  context '#index' do
    it 'render a json of all the cars successfully' do
      subsidiary = Subsidiary.create!(name: 'Av Paulista', cnpj: '28179836000114',
                                      address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP')
      car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                                   car_category: CarCategory.new, manufacturer: Manufacturer.new)
      other_car_model = CarModel.create!(name: 'Fit', year: '2018', motorization: '1.5',
                                         fuel_type: 'Flex', car_category: CarCategory.new,
                                         manufacturer: Manufacturer.new)
      another_car_model = CarModel.create!(name: 'Onix', year: '2018', motorization: '1.5',
                                           fuel_type: 'Flex', car_category: CarCategory.new,
                                           manufacturer: Manufacturer.new)
      car = Car.create!(license_plate: 'JSO1245', color: 'Azul', car_model: car_model,
                        mileage: 100, subsidiary: subsidiary)
      other_car = Car.create!(license_plate: 'RBY4216', color: 'Vermelho', car_model: other_car_model,
                              mileage: 100, subsidiary: subsidiary)
      another_car = Car.create!(license_plate: 'RLS4216', color: 'Preto', car_model: another_car_model,
                                mileage: 100, subsidiary: subsidiary)

      get api_v1_cars_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json.length).to eq(3)
      expect(json[0][:license_plate]).to eq('JSO1245')
      expect(json[0][:color]).to eq('Azul')
      expect(json[0][:car_model_id]).to eq(car.car_model.id)
      expect(json[0][:subsidiary_id]).to eq(car.subsidiary.id)
      expect(json[1][:license_plate]).to eq('RBY4216')
      expect(json[1][:color]).to eq('Vermelho')
      expect(json[1][:car_model_id]).to eq(other_car.car_model.id)
      expect(json[1][:subsidiary_id]).to eq(other_car.subsidiary.id)
      expect(json[2][:license_plate]).to eq('RLS4216')
      expect(json[2][:color]).to eq('Preto')
      expect(json[2][:car_model_id]).to eq(another_car.car_model.id)
      expect(json[2][:subsidiary_id]).to eq(another_car.subsidiary.id)
    end

    it 'there are no registered cars' do
      get api_v1_cars_path

      expect(response).to have_http_status(204)
      expect(response.body).to eq('')
    end
  end

  context '#create' do
    it 'should create a car' do
      subsidiary = Subsidiary.create!(name: 'Av Paulista', cnpj: '28179836000114',
                                      address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP')
      car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                                   car_category: CarCategory.new, manufacturer: Manufacturer.new)

      post api_v1_cars_path, params: {license_plate: 'RLS4216', color: 'Preto',
                                      car_model_id: car_model.id, mileage: 100,
                                      subsidiary_id: subsidiary.id}
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(201)
      expect(json[:license_plate]).to eq('RLS4216')
      expect(json[:color]).to eq('Preto')
      expect(json[:car_model_id]).to eq(car_model.id)
      expect(json[:subsidiary_id]).to eq(subsidiary.id)
    end

    it 'should fail to create a car with invalid data' do
      post api_v1_cars_path, params: {}
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(412)
      expect(json[:car_model]).to include('must exist')
      expect(json[:subsidiary]).to include('must exist')
      expect(json[:license_plate]).to include('A placa não foi informada')
    end
  end

  context '#update' do
    it 'should update car' do
      subsidiary = Subsidiary.create!(name: 'Av Paulista', cnpj: '28179836000114',
                                      address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP')
      car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                                   car_category: CarCategory.new, manufacturer: Manufacturer.new)
      car = Car.create!(license_plate: 'JSO1245', color: 'Azul', car_model: car_model,
                        mileage: 100, subsidiary: subsidiary)

      patch api_v1_car_path(car), params: {license_plate: 'JVA1995', color: 'Preto'}
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(200)
      expect(json[:license_plate]).to eq('JVA1995')
      expect(json[:color]).to eq('Preto')
      expect(json[:mileage]).to eq("100.0")
      expect(json[:car_model_id]).to eq(car_model.id)
      expect(json[:subsidiary_id]).to eq(subsidiary.id)
    end

    it 'cannot find object car' do
      patch api_v1_car_path(id: 777)

      expect(response).to have_http_status(404)
    end

    it 'should fail to update a car with empty data' do
      subsidiary = Subsidiary.create!(name: 'Av Paulista', cnpj: '28179836000114',
                                      address: 'Rua Otávio Tarquínio De Souza, 379, Campo Belo, SP')
      car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5', fuel_type: 'Flex',
                                   car_category: CarCategory.new, manufacturer: Manufacturer.new)
      car = Car.create!(license_plate: 'JSO1245', color: 'Azul', car_model: car_model,
                        mileage: 100, subsidiary: subsidiary)

      patch api_v1_car_path(car), params: {}

      expect(response).to have_http_status(412)
      expect(response.body).to eq('Não houve atualização - Dados invalidos')
    end
  end


end
