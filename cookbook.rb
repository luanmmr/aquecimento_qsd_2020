require_relative 'receita'

INSERIR_RECEITA = 1.freeze
VER_RECEITAS = 2.freeze
BUSCAR_RECEITAS = 3.freeze
SAIR = 4.freeze


def bem_vindo()
  'Bem-vindo ao My Cookbook, sua rede social de receitas culinárias!'
end

def menu()
  puts "#{INSERIR_RECEITA} Cadastrar uma receita"
  puts "#{VER_RECEITAS} Ver todas as receitas"
  puts "#{BUSCAR_RECEITAS} Buscar receitas"
  puts "#{SAIR} Sair"
  print 'Escolha uma opção: '
  gets.to_i
end

def inserir_receita
  print 'Digite o nome da sua receita: '
  nome = gets.chomp
  print 'Digite o tipo da sua receita: '
  tipo = gets.chomp
  puts "Receita de #{nome} do tipo #{tipo} cadastrada com sucesso!"
  Receita.save(nome: nome, tipo: tipo)
end

def imprimir_receitas(receitas = "Vazio!")
  receitas = Receita.ver_todas_receitas if receitas == "Vazio!"
  receitas.each_with_index do |receita, index|
    puts "##{index + 1} - #{receita}"
  end
  puts 'Nenhuma receita encontrada' if receitas.empty?
  puts
end

def buscar_receita()
  puts 'Insira o nome da receita que deseja buscar'
  termo = gets.chomp
  receitas_encontradas = Receita.busca(termo)
  puts "#{receitas_encontradas.length} receita(s) encontrada(s)"
  imprimir_receitas receitas_encontradas unless receitas_encontradas.empty?
  puts
end


puts bem_vindo()
opcao = menu()


while opcao != SAIR
  if opcao == INSERIR_RECEITA
    inserir_receita
    puts
  elsif opcao == VER_RECEITAS
    imprimir_receitas
  elsif opcao == BUSCAR_RECEITAS
    buscar_receita
  else
    puts 'Opção inválida'
  end

  opcao = menu
end

puts 'Obrigado por usar o Cookbook'
