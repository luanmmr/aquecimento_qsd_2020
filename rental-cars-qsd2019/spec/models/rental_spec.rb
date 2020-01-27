require 'rails_helper'

describe Rental do

  describe '#start_date_valid' do
    it 'should not let validate past start date' do
      rental = Rental.new(start_date: 1.day.ago)

      rental.valid?

      expect(rental.errors[:start_date]).to include('Data de início deve ser a '\
                                                    'partir da data atual')
    end

    it 'start date is inserted correctly' do
      rental = Rental.new(start_date: Date.current)

      rental.valid?

      expect(rental.errors[:start_date]).to_not include('Data de início deve ser a '\
                                                        'partir da data atual')
    end
  end

  describe '#end_date_valid' do
    it 'should not let end date before the start date' do
      rental = Rental.new(start_date: Date.current, end_date: 1.day.ago)

      rental.valid?

      expect(rental.errors[:end_date]).to include('Data de término deve ser '\
                                                  'após data de início')
    end

    it 'end date is inserted correctly' do
      rental = Rental.new(start_date: Date.current, end_date: 1.day.from_now)

      rental.valid?

      expect(rental.errors[:end_date]).to_not include('Data de término deve ser '\
                                                      'após data de início')
    end
  end

  describe '#availables_cars' do
    it 'Dates inserted correctly' do
      car_category = CarCategory.create!(name: 'A', daily_rate: 120.00,
                                         car_insurance: 40.50, third_party_insurance: 15)
      car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5',
                                   fuel_type: 'Flex', car_category: car_category,
                                   manufacturer: Manufacturer.new)
      other_car_model = CarModel.create!(name: 'Punto', year: '2018', motorization: '1.5',
                                         fuel_type: 'Flex', car_category: car_category,
                                         manufacturer: Manufacturer.new)
      car = Car.create!(license_plate: 'CAR01', car_model: car_model,
                        color: 'Vermelho', subsidiary: Subsidiary.new)
      other_car = Car.create!(license_plate: 'CAR02', car_model: car_model,
                              color: 'Vermelho', subsidiary: Subsidiary.new)
      rental = Rental.create!(code: 'RENTAL01', car_category: car_category,
                              client: Client.new, user: User.new,
                              start_date: 10.days.from_now, end_date: 17.days.from_now)
      other_rental = Rental.create!(code: 'RENTAL02', car_category: car_category,
                                    client: Client.new, user: User.new,
                                    start_date: 12.days.from_now, end_date: 19.days.from_now)
      another_rental = Rental.new(code: 'RENTAL03', car_category: car_category,
                                      client: Client.new, user: User.new,
                                      start_date: 20.days.from_now, end_date: 21.days.from_now)

      another_rental.valid?

      expect(another_rental.errors[:base]).to_not include('Não há carros dessa categoria '\
                                                          'disponível para o período')
    end

    it 'should not to allow more rentals than cars of the chosen category - '\
       'start date within chosen period' do
      car_category = CarCategory.create!(name: 'A', daily_rate: 120.00,
                                         car_insurance: 40.50, third_party_insurance: 15)
      car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5',
                                   fuel_type: 'Flex', car_category: car_category,
                                   manufacturer: Manufacturer.new)
      other_car_model = CarModel.create!(name: 'Punto', year: '2018', motorization: '1.5',
                                         fuel_type: 'Flex', car_category: car_category,
                                         manufacturer: Manufacturer.new)
      car = Car.create!(license_plate: 'CAR01', car_model: car_model,
                        color: 'Vermelho', subsidiary: Subsidiary.new)
      other_car = Car.create!(license_plate: 'CAR02', car_model: car_model,
                              color: 'Vermelho', subsidiary: Subsidiary.new)
      rental = Rental.create!(code: 'RENTAL01', car_category: car_category,
                              client: Client.new, user: User.new,
                              start_date: 10.days.from_now, end_date: 17.days.from_now)
      other_rental = Rental.create!(code: 'RENTAL02', car_category: car_category,
                                    client: Client.new, user: User.new,
                                    start_date: 12.days.from_now, end_date: 19.days.from_now)
      another_rental = Rental.new(code: 'RENTAL03', car_category: car_category,
                                      client: Client.new, user: User.new,
                                      start_date: 15.days.from_now, end_date: 20.days.from_now)

      another_rental.valid?

      expect(another_rental.errors[:base]).to include('Não há carros dessa categoria '\
                                                      'disponível para o período')
    end

    it 'should not to allow more rentals than cars of the chosen category - '\
       'end date within chosen period' do
      car_category = CarCategory.create!(name: 'A', daily_rate: 120.00,
                                         car_insurance: 40.50, third_party_insurance: 15)
      car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5',
                                   fuel_type: 'Flex', car_category: car_category,
                                   manufacturer: Manufacturer.new)
      other_car_model = CarModel.create!(name: 'Punto', year: '2018', motorization: '1.5',
                                         fuel_type: 'Flex', car_category: car_category,
                                         manufacturer: Manufacturer.new)
      car = Car.create!(license_plate: 'CAR01', car_model: car_model,
                        color: 'Vermelho', subsidiary: Subsidiary.new)
      other_car = Car.create!(license_plate: 'CAR02', car_model: car_model,
                              color: 'Vermelho', subsidiary: Subsidiary.new)
      rental = Rental.create!(code: 'RENTAL01', car_category: car_category,
                              client: Client.new, user: User.new,
                              start_date: 10.days.from_now, end_date: 17.days.from_now)
      other_rental = Rental.create!(code: 'RENTAL02', car_category: car_category,
                                    client: Client.new, user: User.new,
                                    start_date: 12.days.from_now, end_date: 19.days.from_now)
      another_rental = Rental.new(code: 'RENTAL03', car_category: car_category,
                                      client: Client.new, user: User.new,
                                      start_date: 8.days.from_now, end_date: 13.days.from_now)

      another_rental.valid?

      expect(another_rental.errors[:base]).to include('Não há carros dessa categoria '\
                                                      'disponível para o período')
    end

    it 'should not to allow more rentals than cars of the chosen category - '\
       'chosen period within start date and end date' do
      car_category = CarCategory.create!(name: 'A', daily_rate: 120.00,
                                         car_insurance: 40.50, third_party_insurance: 15)
      car_model = CarModel.create!(name: 'Uno', year: '2018', motorization: '1.5',
                                   fuel_type: 'Flex', car_category: car_category,
                                   manufacturer: Manufacturer.new)
      other_car_model = CarModel.create!(name: 'Punto', year: '2018', motorization: '1.5',
                                         fuel_type: 'Flex', car_category: car_category,
                                         manufacturer: Manufacturer.new)
      car = Car.create!(license_plate: 'CAR01', car_model: car_model,
                        color: 'Vermelho', subsidiary: Subsidiary.new)
      other_car = Car.create!(license_plate: 'CAR02', car_model: car_model,
                              color: 'Vermelho', subsidiary: Subsidiary.new)
      rental = Rental.create!(code: 'RENTAL01', car_category: car_category,
                              client: Client.new, user: User.new,
                              start_date: 1.days.from_now, end_date: 30.days.from_now)
      other_rental = Rental.create!(code: 'RENTAL02', car_category: car_category,
                                    client: Client.new, user: User.new,
                                    start_date: 10.days.from_now, end_date: 17.days.from_now)
      another_rental = Rental.new(code: 'RENTAL03', car_category: car_category,
                                      client: Client.new, user: User.new,
                                      start_date: 12.days.from_now, end_date: 16.days.from_now)

      another_rental.valid?

      expect(another_rental.errors[:base]).to include('Não há carros dessa categoria '\
                                                      'disponível para o período')
    end
  end

end
