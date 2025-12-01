-- Atualizações (UPDATE) e deleções (DELETE) com condições
-- Arquivo: updates_deletes_postgres.sql

-- Usar transações para operações que alteram múltiplas linhas
BEGIN;

-- UPDATE 1: marcar um exemplar como não disponível (ex.: danificado)
UPDATE Exemplar
SET Disponibilidade = FALSE, Estado = 'Danificado'
WHERE CodigoEtiqueta = 'EX-002';

-- UPDATE 2: corrigir gênero de um livro
UPDATE Livro
SET Genero = 'Técnico'
WHERE LivroID = 1;

-- UPDATE 3: atualizar telefone de um fornecedor
UPDATE Fornecedor
SET Telefone = '+55 11 99999-1111'
WHERE Nome = 'Livros & Cia';

COMMIT;

-- DELETES (com cuidado às restrições de chave estrangeira)
BEGIN;

-- DELETE 1: remover itens de compra com quantidade zero (limpeza)
DELETE FROM CompraItem
WHERE Quantidade = 0;

-- DELETE 2: remover exemplares muito antigos e não disponíveis
DELETE FROM Exemplar
WHERE DataAquisicao < '2015-01-01' AND Disponibilidade = FALSE;

-- DELETE 3: remover livros que não possuem exemplares (sem armadilha de FK)
DELETE FROM Livro
WHERE LivroID IN (
  SELECT l.LivroID FROM Livro l
  LEFT JOIN Exemplar e ON e.LivroID = l.LivroID
  WHERE e.ExemplarID IS NULL
);

COMMIT;

-- Observação: scripts de DELETE podem precisar ser adaptados dependendo do histórico do banco
-- e de outras FK (por exemplo CompraItem referenciando Livro). Sempre testar em ambiente local/backup.
