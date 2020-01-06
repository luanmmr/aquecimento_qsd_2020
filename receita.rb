class Receita
  attr_accessor :nome, :tipo

  def initialize(nome, tipo)
    @nome = nome
    @tipo = tipo
  end

  def include?(procurar_texto)
    nome.downcase.include? procurar_texto.downcase
  end

  def to_s
    "#{nome} - #{tipo}"
  end
end
