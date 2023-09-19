
# Avaliação Sopha - feita por Pedro

# Sobre

API em Ruby on Rails (versão 5.1.3) construída com um model CRUD de **Store** e um model de autenticação **User**, feito com a gem Devise e Devise-JWT. Testes construídos usando as gems RSpec, Shoulda Matchers e FactoryBot.

## Funcionalidades

As seguintes requisições são possíveis:

- Processo de autenticação de um **User** (Signup, Signin)
- Requisições de **CRUD** (Create, Read, Update, Delete) para **Store**  (Estas requisições só devem ser possíveis se o usuário estiver autenticado)

## Estrutura

A API é constituída por:

- Um Model **User** com os atributos **name, email e password**
- Um Model **Store** com os atributos **name, user_id**
- Onde:
  - **Store** pertence à **User**

## Acesso

A aplicação no ar, subida na AWS EC2, se encontra nesta URL:

    rails-webapp-366100457.sa-east-1.elb.amazonaws.com

**Lembrete:** consultar os endpoints abaixo para que as requisições sejam feitas corretamente.

## Instruções

### No local

Execute o comando para provisionar a aplicação:

    docker-compose up --build

Para acessar o shell do Docker, a fim de criar o banco, realizar as migrações e executar os testes:

    docker exec -it sopha-teste-web-1 sh

Criar e migrar o banco:

    rails db:create && rails db:migrate

Executar os testes sem warnings e com os respectivos nomes e descrições de cada spec:

    RUBYOPT='-W0' rspec -fd

### Requisições

É importante salientar que além da *autenticação* com email e senha, ao criar e fazer o login na aplicação, é devolvido nos `headers` (cabeçalho) de resposta um token JWT do tipo Bearer para *autorização* do usuário de ler, criar, editar e deletar lojas.

Esse token deve ser utilizado e passado na requisição para que as operações de CRUD sejam feitas validamente. Em clients de requisição como **Postman**, **Insomnia** ou **Thunder Client**, nas opções de autorização (Auth) deve se selecionar a opção *Bearer* e em seguida colar o token devolvido nos headers da resposta do login. Esse token tem prazo de expiração de **30 minutos**. Passado esse tempo, o token expira e o usuário deve fazer login novamente a fim de conseguir outro token válido.

Exemplo de requisição realizando login no Insomnia:

![Requisição de login](https://i.imgur.com/ocJiYOi.png)

Na mesma requisição, o envio do token Bearer na resposta:

![Token de autorização](https://i.imgur.com/zCj6v4y.png)

## Endpoints

| Nome da Rota            | Ação          | Endpoint               | Descrição                                    |
|-------------------------|---------------|------------------------|----------------------------------------------|
| Criar usuário           | POST          | /signup                | Cria um novo usuário                         |
| Login do usuário        | POST          | /login                 | Realiza o login do usuário                   |
| Logout do usuário       | DELETE        | /logout                | Realiza o logout do usuário e destrói o token|
| Consultar todas as lojas| GET           | /stores                | Retorna todas as lojas                       |
| Consultar uma loja      | GET           | /stores/:id            | Retorna uma loja específica pelo ID          |
| Criar loja              | POST          | /stores                | Cria uma nova loja                           |
| Editar loja             | PUT/PATCH     | /stores/:id            | Atualiza uma loja existente pelo ID          |
| Deletar loja            | DELETE        | /stores/:id            | Exclui uma loja pelo ID                      |

## Retornos

### Retornos bem-sucedidos

| Rota              | Método | Descrição                          | Respostas bem-sucedidas |
|-------------------|--------|------------------------------------|-------------------------|
| /signup           | POST   | Criar um novo usuário              | 200 OK                  |
| /login            | POST   | Realizar o login do usuário        | 200 OK                  |
| /logout           | DELETE | Realizar o logout do usuário       | 200 OK                  |
| /stores           | GET    | Consultar todas as lojas           | 200 OK                  |
| /stores/:id       | GET    | Consultar uma loja específica      | 200 OK                  |
| /stores           | POST   | Criar uma nova loja                | 201 CREATED             |
| /stores/:id       | PUT/PATCH | Atualizar uma loja existente    | 200 OK                  |
| /stores/:id       | DELETE | Excluir uma loja pelo ID           | 200 OK                  |

### Possíveis retornos de erro

|Retorno de erro  | Provável motivo                          |
|-----------------|------------------------------------------|
|400 BAD REQUEST  | Corpo da requisição foi enviado com erro |
|401 UNAUTHORIZED | Token não foi utilizado ou está expirado/revogado |
|404 NOT FOUND    | Rota não encontrada                      |
