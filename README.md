# Biblioteca Comunitária — Scripts SQL

Mini-mundo: biblioteca comunitaria

Repositório com scripts SQL para criar e popular um banco de dados PostgreSQL para o mini-mundo "biblioteca comunitaria".

Arquivos
- `sql/create_tables_postgres.sql` — criação das tabelas e índices (DDL).
- `sql/inserts_postgres.sql` — inserção de dados de exemplo (DML).
- `sql/selects_postgres.sql` — consultas exemplo (5 queries com JOIN, WHERE, ORDER BY, LIMIT).
- `sql/updates_deletes_postgres.sql` — atualização e remoção de dados (3+ UPDATEs e 3+ DELETEs).

Observações
- Scripts para PostgreSQL (psql / pgAdmin). MySQL requer ajustes mínimos em tipos de dados.

Execução (PowerShell + psql)

1. Criar o banco:
```powershell
createdb biblioteca_comunitaria
```

2. Executar os scripts na ordem:
```powershell
psql -d biblioteca_comunitaria -f sql/create_tables_postgres.sql
psql -d biblioteca_comunitaria -f sql/inserts_postgres.sql
psql -d biblioteca_comunitaria -f sql/selects_postgres.sql
psql -d biblioteca_comunitaria -f sql/updates_deletes_postgres.sql
```

3. Verificar:
```powershell
psql -d biblioteca_comunitaria -c "SELECT COUNT(*) FROM Livro;"
```
