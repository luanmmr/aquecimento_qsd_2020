class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  has_one :car_rental

  validates :color,
  presence: true

  validates :license_plate,
  presence: true,
  uniqueness: true

  validate :valid_license_plate

  validates :mileage,
  presence: true,
  numericality: true


  def full_description
    if car_model.nil? || color.nil? || license_plate.nil?
      I18n.t(:incomplete_car, scope: [:activerecord, :methods, :car,
                                     :full_description])
    else
      "#{car_model.manufacturer.name} #{car_model.name} - #{color} - "\
      "#{license_plate}"
    end
  end

  def valid_license_plate
    unless /\A[A-Z]{3}[0-9]{1}([A-Z]{1}|[0-9]{1})[0-9]{2}\z/.match license_plate
      errors.add(:license_plate, I18n.t(:invalid_license_plate,
         scope: [:activerecord, :methods, :car, :valid_license_plate]))
    end
  end

  def car_category
    car_model.car_category
  end

end
