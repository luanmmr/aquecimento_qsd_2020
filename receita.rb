require 'sqlite3'

class Receita
  attr_accessor :nome, :tipo

  def initialize(nome:, tipo:)
    @nome = nome
    @tipo = tipo
  end

  def self.conecta_banco
    db = SQLite3::Database.open 'database_receitas.db'
    db.results_as_hash = true
    yield(db)
    db.close
  end

  def self.busca(termo)
    receitas_encontradas = []
    self.conecta_banco do |db|
      receitas_encontradas = db.execute <<-SQL, termo.downcase, termo.downcase
      SELECT * FROM receitas
      WHERE nome = ? OR tipo = ?;
      SQL
    end

    receitas_encontradas.map do |receita|
      Receita.new(nome: receita["nome"], tipo: receita["tipo"])
    end
  end

  def self.ver_todas_receitas
    receitas = []
    self.conecta_banco do |db|
      db.execute "SELECT * FROM receitas;" do |receita|
        receitas << Receita.new(nome: receita['nome'], tipo: receita['tipo'])
      end
    end
    receitas
  end

  def self.save(nome:, tipo:)
    self.conecta_banco do |db|
      db.execute <<-SQL, nome.downcase, tipo.downcase
      INSERT INTO receitas (nome, tipo) VALUES (?, ?);
      SQL
    end
  end


  def to_s
    "#{nome} - #{tipo}"
  end

end
