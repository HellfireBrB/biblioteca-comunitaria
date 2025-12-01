-- INSERTs: povoar tabelas principais com dados de exemplo
-- Arquivo: inserts_postgres.sql

BEGIN;

-- Fornecedores
INSERT INTO Fornecedor (Nome, Telefone, Email) VALUES
  ('Livros & Cia', '+55 11 99999-0001', 'contato@livrosecia.com'),
  ('Editora Popular', '+55 21 98888-0002', 'vendas@editorapopular.com'),
  ('Doação Comunidade', '+55 31 97777-0003', 'doacoes@comunidade.org');

-- Livros
INSERT INTO Livro (Titulo, Autor, Editora, AnoPublicacao, Genero) VALUES
  ('Introdução ao PostgreSQL', 'Ana Silva', 'TechPress', 2018, 'Tecnologia'),
  ('Contos da Cidade', 'Carlos Souza', 'Narrativa', 2015, 'Ficção'),
  ('Jardinagem para Todos', 'Marina Lima', 'CasaVerde', 2021, 'Hobby'),
  ('História Local', 'Paulo Pereira', 'Editora Popular', 2010, 'História'),
  ('Programação em Python', 'Luiza Costa', 'TechPress', 2020, 'Tecnologia');

-- Exemplares (vinculados a livros e possivelmente a fornecedores)
INSERT INTO Exemplar (LivroID, CodigoEtiqueta, Estado, Localizacao, DataAquisicao, FornecedorID, Disponibilidade) VALUES
  (1, 'EX-001', 'Bom', 'Estante A1', '2019-03-10', 1, TRUE),
  (1, 'EX-002', 'Novo', 'Estante A1', '2023-06-15', 1, TRUE),
  (2, 'EX-003', 'Usado', 'Estante B2', '2016-08-20', 3, FALSE),
  (3, 'EX-004', 'Novo', 'Estante C3', '2021-11-01', 2, TRUE),
  (4, 'EX-005', 'Bom', 'Estante D4', '2012-02-14', 2, FALSE),
  (5, 'EX-006', 'Novo', 'Estante A2', '2020-09-30', 1, TRUE);

-- Compras
INSERT INTO Compra (DataCompra, FornecedorID, ValorTotal) VALUES
  ('2023-06-15', 1, 0.00),
  ('2021-11-01', 2, 0.00);

-- CompraItems (itens de cada compra)
INSERT INTO CompraItem (CompraID, LivroID, ExemplarID, Quantidade, PrecoUnitario) VALUES
  (1, 1, 2, 5, 45.00),
  (1, 5, 6, 2, 80.00),
  (2, 3, 4, 3, 30.00);

-- Atualizar ValorTotal nas compras com soma dos itens
UPDATE Compra SET ValorTotal = COALESCE((
  SELECT SUM(Quantidade * PrecoUnitario) FROM CompraItem WHERE CompraItem.CompraID = Compra.CompraID
),0);

COMMIT;
