-- Consultas de exemplo (SELECT) para avaliação
-- Arquivo: selects_postgres.sql

-- 1) Listar livros com quantidade total de exemplares e quantidade disponíveis
SELECT
  l.LivroID,
  l.Titulo,
  COUNT(e.ExemplarID) AS total_exemplares,
  SUM(CASE WHEN e.Disponibilidade THEN 1 ELSE 0 END) AS disponiveis
FROM Livro l
LEFT JOIN Exemplar e ON e.LivroID = l.LivroID
GROUP BY l.LivroID, l.Titulo
ORDER BY total_exemplares DESC
LIMIT 5;

-- 2) Compras com nome do fornecedor e valor total (join e order)
SELECT
  c.CompraID,
  c.DataCompra,
  f.Nome AS Fornecedor,
  c.ValorTotal
FROM Compra c
LEFT JOIN Fornecedor f ON f.FornecedorID = c.FornecedorID
ORDER BY c.DataCompra DESC
LIMIT 10;

-- 3) Exemplares disponíveis de gênero 'Tecnologia' (join, where, order)
SELECT
  e.ExemplarID,
  e.CodigoEtiqueta,
  l.Titulo,
  l.Genero,
  e.DataAquisicao
FROM Exemplar e
JOIN Livro l ON l.LivroID = e.LivroID
WHERE e.Disponibilidade = TRUE AND l.Genero = 'Tecnologia'
ORDER BY e.DataAquisicao DESC
LIMIT 10;

-- 4) Livros publicados depois de 2015 ordenados por ano
SELECT LivroID, Titulo, Autor, AnoPublicacao
FROM Livro
WHERE AnoPublicacao > 2015
ORDER BY AnoPublicacao DESC;

-- 5) Itens de compra com preço unitário maior que 40 (join com Compra e Fornecedor)
SELECT ci.CompraItemID, ci.CompraID, c.DataCompra, ci.LivroID, ci.Quantidade, ci.PrecoUnitario, f.Nome AS Fornecedor
FROM CompraItem ci
JOIN Compra c ON c.CompraID = ci.CompraID
LEFT JOIN Fornecedor f ON f.FornecedorID = c.FornecedorID
WHERE ci.PrecoUnitario > 40
ORDER BY ci.PrecoUnitario DESC;
