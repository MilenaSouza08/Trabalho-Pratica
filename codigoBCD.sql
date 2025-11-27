-- =============================================
-- 1️⃣ Tabela de Usuários
-- =============================================
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    login VARCHAR(50) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    senha VARCHAR(20) NOT NULL
);

-- =============================================
-- 2️⃣ Tabela de Categorias
-- =============================================
CREATE TABLE categoria (
    idcategoria SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(500)
);

-- =============================================
-- 3️⃣ Tabela de Produtos
-- =============================================
CREATE TABLE produto (
    idproduto SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    idcategoria INTEGER REFERENCES categoria(idcategoria),
    fabricante VARCHAR(100),
    preco_venda NUMERIC(10,2) DEFAULT 0,
    descricao VARCHAR(500),
    estoque_minimo INTEGER DEFAULT 0
);

-- =============================================
-- 4️⃣ Tabela de Saldos (controle atual de estoque)
-- =============================================
CREATE TABLE saldos (
    idproduto INTEGER PRIMARY KEY,
    saldo INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (idproduto) REFERENCES produto(idproduto) ON DELETE CASCADE
);

-- =============================================
-- 5️⃣ Tabela de Movimentos (histórico de entradas e saídas)
-- =============================================
CREATE TABLE movimento_estoque (
    idmovimento SERIAL PRIMARY KEY,
    idproduto INTEGER REFERENCES produto(idproduto),
    tipo CHAR(1) CHECK (tipo IN ('E','S')),
    quantidade INTEGER CHECK (quantidade > 0),
    data_movimento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    observacao VARCHAR(500)
);

-- =============================================
-- Inserts
-- =============================================

-- Usuário padrão
INSERT INTO usuarios (login, nome, senha) VALUES
('milena', 'Milena Oliveira', '1234'),
('admin', 'Administrador do Sistema', 'admin123'),
('luiz', 'Luiz ALves', 'senha123');


-- Categorias
INSERT INTO categoria (nome, descricao) VALUES
('Bebidas', 'Refrigerantes, sucos e bebidas em geral'),
('Limpeza', 'Produtos de limpeza doméstica'),
('Higiene', 'Itens de uso pessoal'),
('Alimentos', 'Mantimentos e produtos alimentícios');


-- Produtos
INSERT INTO produto (nome, idcategoria, fabricante, preco_venda, descricao, estoque_minimo) VALUES
('Coca-Cola 2L', 1, 'Coca-Cola Company', 8.50, 'Refrigerante sabor cola', 10),
('Sabão em Pó 1kg', 2, 'OMO', 12.90, 'Sabão em pó para roupas', 5),
('Shampoo 300ml', 3, 'Pantene', 15.00, 'Shampoo para cabelo liso', 8),
('Arroz Tipo 1 - 5kg', 4, 'Tio João', 22.00, 'Arroz branco tipo 1', 6),
('Suco de Laranja 1L', 1, 'Del Valle', 6.20, 'Suco natural de laranja', 10);

-- Saldos (valores iniciais)
INSERT INTO saldos (idproduto, saldo) VALUES
(1, 30),
(2, 15),
(3, 40),
(4, 20),
(5, 25);

-- Movimentos iniciais		
INSERT INTO movimento_estoque (idproduto, tipo, quantidade, observacao) VALUES
(1, 'E', 50, 'Compra inicial'),
(1, 'S', 20, 'Venda no caixa'),
(2, 'E', 30, 'Reposição de estoque'),
(3, 'S', 10, 'Venda online'),
(4, 'E', 40, 'Entrega do fornecedor'),
(5, 'S', 15, 'Consumo interno'),
(5, 'E', 20, 'Reposição semanal');

select * from produto

DROP TABLE movimento_estoque 
DROP TABLE  saldos 
DROP TABLE  produto 
DROP TABLE  categoria 
DROP TABLE  usuarios 
