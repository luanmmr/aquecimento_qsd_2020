class SubsidiariesController < ApplicationController

  http_basic_authenticate_with name: 'admin', password: '123', only: [:new, :edit, :destroy]

  def new
    @subsidiary = Subsidiary.new
  end

  def create
    @subsidiary = Subsidiary.new(subsidiary_params)
    if @subsidiary.save
      flash[:notice] = 'Cadastrada com sucesso!'
      redirect_to @subsidiary
    else
      render :new
    end
  end

  def index
    @subsidiaries = Subsidiary.all
  end

  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  def edit
    @subsidiary = Subsidiary.find(params[:id])
  end

  def update
    @subsidiary = Subsidiary.find(params[:id])
    if @subsidiary.update(subsidiary_params)
      flash[:notice] = 'Editado com sucesso!'
      redirect_to @subsidiary
    else
      render :edit
    end
  end

  def destroy
    @subsidiary = Subsidiary.find(params[:id])
    @subsidiary.destroy
    redirect_to subsidiaries_path
  end


  private
  def subsidiary_params
    params.require(:subsidiary).permit(:name, :address, :cnpj)
  end


end
