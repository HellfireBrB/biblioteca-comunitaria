
DROP TABLE IF EXISTS CompraItem CASCADE;
DROP TABLE IF EXISTS Compra CASCADE;
DROP TABLE IF EXISTS Exemplar CASCADE;
DROP TABLE IF EXISTS Livro CASCADE;
DROP TABLE IF EXISTS Fornecedor CASCADE;


CREATE TABLE Fornecedor (
  FornecedorID SERIAL PRIMARY KEY,
  Nome VARCHAR(150) NOT NULL,
  Telefone VARCHAR(20),
  Email VARCHAR(150)
);


CREATE TABLE Livro (
  LivroID SERIAL PRIMARY KEY,
  Titulo VARCHAR(255) NOT NULL,
  Autor VARCHAR(150),
  Editora VARCHAR(150),
  AnoPublicacao INT,
  Genero VARCHAR(100)
);


CREATE TABLE Exemplar (
  ExemplarID SERIAL PRIMARY KEY,
  LivroID INT NOT NULL REFERENCES Livro(LivroID) ON DELETE CASCADE,
  CodigoEtiqueta VARCHAR(50) UNIQUE,
  Estado VARCHAR(100),
  Localizacao VARCHAR(100),
  DataAquisicao DATE,
  FornecedorID INT REFERENCES Fornecedor(FornecedorID),
  Disponibilidade BOOLEAN DEFAULT TRUE
);


CREATE TABLE Compra (
  CompraID SERIAL PRIMARY KEY,
  DataCompra DATE NOT NULL,
  FornecedorID INT REFERENCES Fornecedor(FornecedorID),
  ValorTotal NUMERIC(12,2)
);


CREATE TABLE CompraItem (
  CompraItemID SERIAL PRIMARY KEY,
  CompraID INT NOT NULL REFERENCES Compra(CompraID) ON DELETE CASCADE,
  LivroID INT REFERENCES Livro(LivroID),
  ExemplarID INT REFERENCES Exemplar(ExemplarID),
  Quantidade INT NOT NULL CHECK (Quantidade >= 0),
  PrecoUnitario NUMERIC(10,2) NOT NULL
);


CREATE INDEX idx_exemplar_livro ON Exemplar(LivroID);
CREATE INDEX idx_compra_fornecedor ON Compra(FornecedorID);
