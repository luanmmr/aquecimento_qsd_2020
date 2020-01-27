require 'rails_helper'

describe Car do

  describe '#full_description' do
    it 'should show manufacturer name, model name, color and license_plate' do
      manufacturer = Manufacturer.new(name: 'Honda')
      car_model = CarModel.new(name: 'Fit', manufacturer: manufacturer)
      car = Car.new(car_model: car_model, color: 'Cinza', license_plate: 'XML1245')

      expect(car.full_description).to eq('Honda Fit - Cinza - XML1245')
    end

    it 'should not generate full description if car model is nil' do
      manufacturer = Manufacturer.new(name: 'Honda')
      car_model = CarModel.new(name: 'Fit', manufacturer: manufacturer)
      car = Car.new(color: 'Cinza', license_plate: 'XML1245')

      expect(car.full_description).to eq('Carro não cadastro corretamente')
    end

    it 'should not generate full description if color is nil' do
      manufacturer = Manufacturer.new(name: 'Honda')
      car_model = CarModel.new(name: 'Fit', manufacturer: manufacturer)
      car = Car.new(car_model: car_model, license_plate: 'XML1245')

      expect(car.full_description).to eq('Carro não cadastro corretamente')
    end

    it 'should not generate full description if license plate is nil' do
      manufacturer = Manufacturer.new(name: 'Honda')
      car_model = CarModel.new(name: 'Fit', manufacturer: manufacturer)
      car = Car.new(car_model: car_model, color: 'Cinza')

      expect(car.full_description).to eq('Carro não cadastro corretamente')
    end
  end
  
end
