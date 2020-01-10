class ManufacturersController < ApplicationController


  def new
    @manufacturer = Manufacturer.new
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if @manufacturer.save
      # Esse flash vai para a próxima requisição, ou seja, após o redirect_to
      # vai para o show. A view show terá acesso, mas depois esse flash morre.
      flash[:notice] = 'Fabricante criada com sucesso!'
      redirect_to @manufacturer
      # A mesma coisa que  redirect_to manufacturer_path(@manufacturer)
      # Pode fazer também render :show
      # O render :show exibe diretamente na action create, a view de show, ou seja
      # exibe o show.html.rb no corpo da action create. Atenção:: Se mudar o nome da varíavel
      # @manufacturer vai dar erro. Ao chamar render :show, na view de show, a variável
      # utilizada é exatamente de mesmo nome como @manufacturer
    else
      # Com o flash.now, ele não envia para a próxima requisão, e sim já exibe na atual
      # neste caso na Action create. Na view show deverá declarar flash[:alert] para funcionar
      # flash.now[:alert] = 'Você deve corrigir os seguintes erros para continuar:'
      render :new
    end
  end

  def index
    @manufacturers = Manufacturer.all
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
  end

  def edit
    @manufacturer = Manufacturer.find(params[:id])
  end

  def update
    @manufacturer = Manufacturer.find(params[:id])
    if @manufacturer.update(manufacturer_params)
      flash[:notice] = 'Fábrica editada com sucesso!'
      redirect_to manufacturer_path @manufacturer
    else
      render :edit
    end
  end

  def destroy
    Manufacturer.destroy(params[:id])
    redirect_to manufacturers_path, notice: 'Fábrica deletada com sucesso'
  end



  private

  def manufacturer_params
    params.require(:manufacturer).permit(:name)
  end


end
