class RentalsController < ApplicationController

  before_action :authenticate_user!

  def index
    @rentals = Rental.all
  end

  def search
    # Busca exata
    #@rentals = Rental.where(code: params[:q])
    # Outro modo de busca exata, agora, utilizando SQL
    #@rentals = Rental.where("code LIKE ?", "#{params[:q]}")
    @rentals = Rental.where("code LIKE ?", "%#{params[:q]}%")
  end

end
