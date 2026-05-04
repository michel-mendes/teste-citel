# Teste Técnico Citel - Tela de Pedidos de Venda

Este repositório contém a implementação do teste técnico para a vaga de Desenvolvedor Delphi na **Citel**. O projeto foca em boas práticas de engenharia de software, separação de responsabilidades e performance em banco de dados.

## 🛠️ Arquitetura e Decisões de Design

O projeto foi estruturado seguindo o padrão de *Três Camadas** adaptado para  Delphi, visando fácil entendimento e manutenção:

1.  **Model (Entidades):** Classes que representam as tabelas do banco de dados, garantindo que o domínio do negócio seja independente de frameworks.
2.  **Repository (Acesso a Dados):** Camada responsável pela interação com o banco de dados.
3.  **View (Apresentação):** Interface VCL desacoplada da lógica de persistência, interagindo apenas com os Repositórios.

## 🚀 Funcionalidades Principais
1. **Lançamento de Itens**: Inserção dinâmica com busca por código de produto.
2. **Grid de produtos**: Navegação via teclado (Setas Up/Down).
3. **Edição de itens** existentes pressionando ENTER sobre a linha.
4. **Exclusão de itens** pressionando DEL com confirmação de segurança.
5. **Gestão de Pedidos Gravados**: Botões de "Carregar" e "Apagar" permitindo a recuperação/exclusão de pedidos por número sequencial.
6. **Validações**: verificação de existência de registros no banco antes de operações de gravação ou exclusão.

## 🚀 Tecnologias Utilizadas
- **Delphi 12 Community Edition**
- **MySQL 8.0**
- **FireDAC** (Acesso a dados)
- **Biblioteca libmysql.dll (Versão x64)** (Necessária na pasta de execução)

## Parâmetros de Conexão com o Banco de Dados MySQL
- Alterar as credenciais de acesso em "src/common/UConnection.DataModule.pas" para que não haja erro de conexão ao inicializar a aplicação.

## 📁 Estrutura de Pastas
```text
CitelTest/
├── bin/                # Binários compilados (.exe) + libmysql.dll
├── dcu/                # Unidades compiladas (.dcu)
└── src/
    ├── Common/         # conexão global (DataModule)
    ├── Model/          # Classes de representação de dados (Entidades)
    ├── Repository/     # Lógica de persistência
    └── View/           # Telas e interface com o usuário