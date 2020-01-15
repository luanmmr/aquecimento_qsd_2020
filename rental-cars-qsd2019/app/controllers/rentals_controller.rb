class RentalsController < ApplicationController

  before_action :authenticate_user!

  def index
    @rentals = Rental.all
  end

  def search
    @rentals = Rental.where(code: params[:q])
  end

end
