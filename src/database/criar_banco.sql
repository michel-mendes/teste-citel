-- Criação do banco de dados
CREATE DATABASE teste_citel_michel_mendes;
USE teste_citel_michel_mendes;



-- Criação da tabela de clientes
CREATE TABLE clientes (
    codigo INT auto_increment,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(60) NOT NULL,
    uf CHAR(2) NOT NULL,
    PRIMARY KEY (codigo)
);
CREATE INDEX idx_clientes_Nome ON clientes(nome);



-- Criação da tablea de produtos
-- Utilizei incremental em "codigo" coniderando-o como "ID"
-- Pensando em "código de barras" o incremental não seria utilizado
CREATE TABLE produtos (
	codigo INT auto_increment,
    descricao VARCHAR(100) NOT NULL,
    preco_venda DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (codigo)
);
CREATE INDEX idx_produtos_descricao ON produtos(descricao);



-- Criação da tabela de pedidos
CREATE TABLE pedidos(
	numero_pedido INT auto_increment,
    data_emissao DATETIME NOT NULL DEFAULT current_timestamp,
    codigo_cliente INT NOT NULL,
    valor_total DECIMAL(15, 2) NOT NULL,
    PRIMARY KEY (numero_pedido),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (codigo_cliente) REFERENCES clientes(codigo)
);
CREATE INDEX idx_pedidos_data_emissao ON pedidos(data_emissao);



-- Criação da tabela de itens do pedido
CREATE TABLE itens_pedido (
	codigo BIGINT auto_increment,
    numero_pedido INT NOT NULL,
    codigo_produto INT NOT NULL,
    quantidade DECIMAL(15, 3) NOT NULL,
    vr_unitario DECIMAL(15, 2) NOT NULL,
    vr_total DECIMAL(15, 2) NOT NULL,
    PRIMARY KEY (codigo),
    CONSTRAINT fk_numero_pedido FOREIGN KEY (numero_pedido) REFERENCES pedidos(numero_pedido) ON DELETE CASCADE,
    CONSTRAINT fk_codigo_produto FOREIGN KEY (codigo_produto) REFERENCES produtos(codigo)
);


-- Script para popular a tabela clientes com 30 registros
INSERT INTO clientes(nome, cidade, uf) VALUES("Cliente À Vista", "São Paulo", "SP");
INSERT INTO clientes(nome, cidade, uf) VALUES("Mariana Alves Ribeiro", "Belo Horizonte", "MG");
INSERT INTO clientes(nome, cidade, uf) VALUES("João Pedro Martins", "Curitiba", "PR");
INSERT INTO clientes(nome, cidade, uf) VALUES("Fernanda Costa Lima", "Salvador", "BA");
INSERT INTO clientes(nome, cidade, uf) VALUES("Lucas Gabriel Ferreira", "Fortaleza", "CE");
INSERT INTO clientes(nome, cidade, uf) VALUES("Ana Clara Mendes", "Recife", "PE");
INSERT INTO clientes(nome, cidade, uf) VALUES("Rafael Teixeira Gomes", "Porto Alegre", "RS");
INSERT INTO clientes(nome, cidade, uf) VALUES("Juliana Barros Nogueira", "Goiânia", "GO");
INSERT INTO clientes(nome, cidade, uf) VALUES("Bruno Rodrigues da Silva", "São Paulo", "SP");
INSERT INTO clientes(nome, cidade, uf) VALUES("Patrícia Fernandes Rocha", "Rio de Janeiro", "RJ");
INSERT INTO clientes(nome, cidade, uf) VALUES("Felipe Cardoso Pinto", "Florianópolis", "SC");
INSERT INTO clientes(nome, cidade, uf) VALUES("Camila Duarte Lopes", "Vitória", "ES");
INSERT INTO clientes(nome, cidade, uf) VALUES("Gustavo Henrique Araújo", "Manaus", "AM");
INSERT INTO clientes(nome, cidade, uf) VALUES("Larissa Monteiro Freitas", "Belém", "PA");
INSERT INTO clientes(nome, cidade, uf) VALUES("Eduardo Pacheco Tavares", "Brasília", "DF");
INSERT INTO clientes(nome, cidade, uf) VALUES("Beatriz Carvalho Moraes", "Natal", "RN");
INSERT INTO clientes(nome, cidade, uf) VALUES("Diego Batista Ribeiro", "João Pessoa", "PB");
INSERT INTO clientes(nome, cidade, uf) VALUES("Aline Gonçalves Castro", "Maceió", "AL");
INSERT INTO clientes(nome, cidade, uf) VALUES("Vinícius Farias Neves", "Aracaju", "SE");
INSERT INTO clientes(nome, cidade, uf) VALUES("Renata Oliveira Cunha", "Teresina", "PI");
INSERT INTO clientes(nome, cidade, uf) VALUES("Thiago Peixoto Ramos", "Campo Grande", "MS");
INSERT INTO clientes(nome, cidade, uf) VALUES("Carolina Barbosa Vieira", "Cuiabá", "MT");
INSERT INTO clientes(nome, cidade, uf) VALUES("André Luiz Correia", "São Luís", "MA");
INSERT INTO clientes(nome, cidade, uf) VALUES("Tatiane Moura Santana", "Palmas", "TO");
INSERT INTO clientes(nome, cidade, uf) VALUES("Leonardo Figueiredo Braga", "Ribeirão Preto", "SP");
INSERT INTO clientes(nome, cidade, uf) VALUES("Priscila Andrade Rezende", "Uberlândia", "MG");
INSERT INTO clientes(nome, cidade, uf) VALUES("Rodrigo Sales Cavalcante", "Londrina", "PR");
INSERT INTO clientes(nome, cidade, uf) VALUES("Vanessa Martins Pires", "Santos", "SP");
INSERT INTO clientes(nome, cidade, uf) VALUES("Marcelo Vieira Bastos", "Niterói", "RJ");
INSERT INTO clientes(nome, cidade, uf) VALUES("Daniela Lopes Guimarães", "Sorocaba", "SP");

-- Script para popular a tabela produtos com 30 produtos
INSERT INTO produtos(descricao, preco_venda) VALUES("Porcelanato Acetinado 60x60cm Caixa 2,16m²", 79.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Piso Cerâmico 75x75cm Classe A Caixa 2,00m²", 39.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Rejunte Resinado Branco 1kg", 12.50);
INSERT INTO produtos(descricao, preco_venda) VALUES("Argamassa AC2 Interna 20kg", 24.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Argamassa AC3 Externa 20kg", 39.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Cimento CP II 50kg", 34.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Areia Média Lavada 1m³", 140.00);
INSERT INTO produtos(descricao, preco_venda) VALUES("Brita 1 1m³", 160.00);
INSERT INTO produtos(descricao, preco_venda) VALUES("Tinta Acrílica Fosca Branca 18L", 249.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Tinta Esmalte Sintético Branco 3,6L", 89.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Massa Corrida PVA 25kg", 79.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Selador Acrílico 18L", 189.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Rolo de Pintura Antigota 23cm", 18.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Trincha Média 2 Polegadas", 9.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Espaçador Nivelador de Piso 2mm 100un", 22.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Nivelador de Piso Tipo Cunha 50un", 27.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Caixa de Luz 4x2 Embutir", 2.50);
INSERT INTO produtos(descricao, preco_venda) VALUES("Tomada Simples 10A Branca", 6.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Interruptor Simples 1 Tecla", 7.50);
INSERT INTO produtos(descricao, preco_venda) VALUES("Fio Flexível 2,5mm Rolo 100m", 189.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Disjuntor Monofásico 20A", 14.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Chuveiro Elétrico 5500W", 119.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Torneira de Cozinha Metal Cromado", 89.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Vaso Sanitário Convencional Branco", 299.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Caixa Acoplada 6L Branco", 219.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Cuba de Apoio Redonda Branca", 149.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Gabinete para Banheiro 60cm MDF", 399.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Espelho para Banheiro 60x80cm", 129.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Porta de Madeira Lisa 80cm", 249.90);
INSERT INTO produtos(descricao, preco_venda) VALUES("Fechadura Interna Cromada", 39.90);