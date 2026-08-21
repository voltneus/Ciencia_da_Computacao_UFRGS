# Esquema Relacional e Dicionário de dados

## 1. Tabela: GAME

* Armazena as informações principais de cada jogo disponível na plataforma Steam.

### Dicionário de Dados
| Atributo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `codgame` | `SERIAL` | `PRIMARY KEY`, `NOT NULL` | Código identificador único e autoincremental do jogo. |
| `gamename` | `VARCHAR(255)` | `UNIQUE`, `NOT NULL` | Título oficial do jogo (deve ser único). |
| `price` | `DECIMAL(10, 2)` | `NOT NULL`, `DEFAULT 0.00`, `CHECK >= 0` | Preço de venda do jogo em moeda corrente. |
| `description` | `TEXT` | `NOT NULL` | Descrição detalhada sobre o jogo, sinopse ou requisitos. |
| `launch_date` | `DATE` | `NOT NULL` | Data oficial de lançamento do jogo. |
| `estimated_owners` | `VARCHAR(100)` | `NOT NULL` | Estimativa de número de donos do jogo na plataforma Steam - não reflete a quantidade de registros GAMELIBRARY |
| `positive_reviews` | `INT` | `NOT NULL` | Quantidade de avaliações positivas acumuladas. |
| `negative_reviews` | `INT` | `NOT NULL` | Quantidade de avaliações negativas acumuladas. |
| `average_play_time` | `INT` | `NOT NULL` | Tempo médio de jogo registrado (em minutos). |

### Justificativa de Normalização (FNBC)
* **Dependência Funcional (DF):**
  * `codgame -> gamename, price, description, launch_date, estimated_owners, positive_reviews, negative_reviews, average_play_time`
  * `gamename -> codgame, price, description, launch_date, estimated_owners, positive_reviews, negative_reviews, average_play_time`
* Os determinantes na tabela são `codgame` (chave primária) e `gamename` (chave alternativa por ser `UNIQUE`). Ambas são chaves candidatas (superchaves). Como todos os determinantes são superchaves, a tabela `GAME` está em conformidade com a Forma Normal de Boyce-Codd (FNBC).

### DDL em PostgreSQL
```sql
CREATE TABLE GAME (
    codgame SERIAL PRIMARY KEY,
    gamename VARCHAR(255) NOT NULL UNIQUE,
    price DECIMAL(10, 2) NOT NULL DEFAULT 0.00 CHECK (price >= 0.00),
    description TEXT NOT NULL,
    estimated_owners VARCHAR(100) NOT NULL,
    launch_date DATE NOT NULL,
    positive_reviews INT NOT NULL,
    negative_reviews INT NOT NULL,
    average_play_time INT NOT NULL
);
```

## 2. Tabela: GAMEUSER

* Armazena os dados cadastrais, saldo da carteira e informações pessoais dos usuários da plataforma Steam.

### Dicionário de Dados
| Atributo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `coduser` | `SERIAL` | `PRIMARY KEY`, `NOT NULL` | Código identificador único e autoincremental do usuário. |
| `username` | `VARCHAR(100)` | `UNIQUE`, `NOT NULL` | Nome de exibição único do usuário na plataforma. |
| `email` | `VARCHAR(255)` | `UNIQUE`, `NOT NULL` | Endereço de e-mail exclusivo associado à conta do usuário. |
| `password_hash` | `VARCHAR(255)` | `NOT NULL` | Hash da senha do usuário para autenticação segura. |
| `wallet_balance` | `DECIMAL(10, 2)` | `NOT NULL`, `DEFAULT 0.00` | Saldo disponível na carteira virtual do usuário. |
| `birth_date` | `DATE` | `NOT NULL` | Data de nascimento do usuário. |
| `birth_name` | `VARCHAR(100)` | `NOT NULL` | Nome de registro legal completo do usuário. |

### Justificativa de Normalização (FNBC)
* **Dependência Funcional (DF):** 
  * `coduser -> username, email, password_hash, wallet_balance, birth_date, birth_name`, 
  * `username -> coduser, email, password_hash, wallet_balance, birth_date, birth_name`, 
  * `email -> coduser, username, password_hash, wallet_balance, birth_date, birth_name` 
 
* Os determinantes na tabela são `coduser`, `username` e `email`, todos eles são chaves candidatas devido às restrições `PRIMARY KEY` e `UNIQUE`. Como todos os determinantes são superchaves, a tabela `GAMEUSER` está em conformidade com a Forma Normal de Boyce-Codd (FNBC).

### DDL em PostgreSQL
```sql
CREATE TABLE GAMEUSER (
    coduser SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    wallet_balance DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    birth_date DATE NOT NULL,
    birth_name VARCHAR(100) NOT NULL
);
```

## 3. Tabela: DEVELOPER

* Armazena os perfis das empresas desenvolvedoras de jogos.

### Dicionário de Dados
| Atributo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `coddev` | `SERIAL` | `PRIMARY KEY`, `NOT NULL` | Código identificador único e autoincremental da desenvolvedora. |
| `devname` | `VARCHAR(255)` | `UNIQUE`, `NOT NULL` | Nome da empresa ou estúdio de desenvolvimento (deve ser único). |

### Justificativa de Normalização (FNBC)
* **Dependência Funcional (DF):**
  * `coddev -> devname`
  * `devname -> coddev`
* Os determinantes na tabela são `coddev` (chave primária) e `devname` (chave alternativa por ser `UNIQUE`). Ambas são chaves candidatas (superchaves). Como todos os determinantes são superchaves, a tabela está em conformidade com a FNBC.

### DDL em PostgreSQL
```sql
CREATE TABLE DEVELOPER (
    coddev SERIAL PRIMARY KEY,
    devname VARCHAR(255) NOT NULL UNIQUE
);
```

## 4. Tabela: TAG

* Armazena as categorias ou marcadores de gênero utilizados para classificar os jogos.

### Dicionário de Dados
| Atributo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `codtag` | `SERIAL` | `PRIMARY KEY`, `NOT NULL` | Código identificador único e autoincremental da tag. |
| `nametag` | `VARCHAR(100)` | `UNIQUE`, `NOT NULL` | Nome do marcador de gênero (ex: RPG, Action, Indie). |

### Justificativa de Normalização (FNBC)
* **Dependência Funcional (DF):**
  * `codtag -> nametag`
  * `nametag -> codtag`
* Os determinantes na tabela são `codtag` (chave primária) e `nametag` (chave alternativa por ser `UNIQUE`). Ambas são chaves candidatas e como todos os determinantes na tabela são superchaves, a tabela esta em conformidade com a FNBC.

### DDL em PostgreSQL
```sql
CREATE TABLE TAG (
    codtag SERIAL PRIMARY KEY,
    nametag VARCHAR(100) NOT NULL UNIQUE
);
```

## 5. Tabela: GAMEDEVELOPER

* Tabela associativa que vincula jogos às suas respectivas empresas desenvolvedoras.

### Dicionário de Dados
| Atributo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `codgame` | `INT` | `PRIMARY KEY`, `FK` references `GAME(codgame)` | Código do jogo associado, referencia o atributo `codgame` na tabela `GAME`. |
| `coddev` | `INT` | `PRIMARY KEY`, `FK` references `DEVELOPER(coddev)` | Código da desenvolvedora associada, referencia o atributo `coddev` na tabela `DEVELOPER`. |

### Justificativa de Normalização (FNBC)
* O único determinante é a chave primária composta `(codgame, coddev)`. Como não existem dependências funcionais de atributos não chave e o único determinante é uma superchave, a tabela está em conformidade com a FNBC.

### DDL em PostgreSQL
```sql
CREATE TABLE GAMEDEVELOPER (
    codgame INT,
    coddev INT,
    PRIMARY KEY (codgame, coddev),
    FOREIGN KEY (codgame) REFERENCES GAME(codgame),
    FOREIGN KEY (coddev) REFERENCES DEVELOPER(coddev)
);
```

## 6. Tabela: GAMETAG

* Tabela associativa que vincula jogos aos seus marcadores de gênero (relacionamento muitos-para-muitos).

### Dicionário de Dados
| Atributo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `codgame` | `INT` | `PRIMARY KEY`, `FK` references `GAME(codgame)` | Código do jogo associado, referencia o atributo `codgame` na tabela `GAME`. |
| `codtag` | `INT` | `PRIMARY KEY`, `FK` references `TAG(codtag)` | Código da tag associada, referencia o atributo `codtag` na tabela `TAG`. |

### Justificativa de Normalização (FNBC)
* O único determinante é a chave primária composta `(codgame, codtag)`. Como não existem dependências funcionais de atributos não chave, a tabela está em conformidade com a FNBC.

### DDL em PostgreSQL
```sql
CREATE TABLE GAMETAG (
    codgame INT,
    codtag INT,
    PRIMARY KEY (codgame, codtag),
    FOREIGN KEY (codgame) REFERENCES GAME(codgame),
    FOREIGN KEY (codtag) REFERENCES TAG(codtag)
);
```

## 7. Tabela: REVIEWS

* Armazena as avaliações escritas e recomendações que os usuários fazem dos jogos.

### Dicionário de Dados
| Atributo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `coduser` | `INT` | `PRIMARY KEY`, `FK` references `GAMEUSER(coduser)` | Código do usuário que realizou a avaliação, referencia o atributo `coduser` na tabela `GAMEUSER`. |
| `codgame` | `INT` | `PRIMARY KEY`, `FK` references `GAME(codgame)` | Código do jogo avaliado, referencia o atributo `codgame` na tabela `GAME`. |
| `ispositive` | `BOOLEAN` | `NOT NULL` | Sinaliza se a avaliação é positiva (true) ou negativa (false). |
| `review` | `TEXT` | Nenhuma | Texto opcional contendo a análise escrita do usuário sobre o jogo. |

### Justificativa de Normalização (FNBC)
* **Dependência Funcional (DF):**
  * `(coduser, codgame) -> ispositive, review`
* O único determinante é a chave primária composta `(coduser, codgame)`. Como não existem dependências funcionais de atributos não chave e o único determinante é uma superchave, a tabela está em conformidade com a FNBC.

### DDL em PostgreSQL
```sql
CREATE TABLE REVIEWS (
    coduser INT NOT NULL,
    codgame INT NOT NULL,
    ispositive BOOLEAN NOT NULL,
    review TEXT,
    PRIMARY KEY (coduser, codgame),
    FOREIGN KEY (coduser) REFERENCES GAMEUSER(coduser),
    FOREIGN KEY (codgame) REFERENCES GAME(codgame)
);
```

## 8. Tabela: GAMELIBRARY

* Mapeia os jogos adquiridos pelos usuários, registrando a data de aquisição e o tempo acumulado de jogo.

### Dicionário de Dados
| Atributo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `codgame` | `INT` | `PRIMARY KEY`, `FK` references `GAME(codgame)` | Código do jogo adquirido, referencia o atributo `codgame` na tabela `GAME`. |
| `coduser` | `INT` | `PRIMARY KEY`, `FK` references `GAMEUSER(coduser)` | Código do usuário proprietário do jogo, referencia o atributo `coduser` na tabela `GAMEUSER`. |
| `purchase_date` | `TIMESTAMP` | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Data e hora em que o jogo foi adicionado à biblioteca do usuário. |
| `playtime` | `INT` | `NOT NULL`, `DEFAULT 0` | Tempo acumulado de jogo registrado em minutos. |

### Justificativa de Normalização (FNBC)
* **Dependência Funcional (DF):**
  * `(codgame, coduser) -> purchase_date, playtime`
* O único determinante é a chave primária composta `(codgame, coduser)`. Como não existem dependências funcionais de atributos não chave e o único determinante é uma superchave, a tabela está em conformidade com a FNBC.

### DDL em PostgreSQL
```sql
CREATE TABLE GAMELIBRARY (
    codgame INT,
    coduser INT,
    purchase_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    playtime INT NOT NULL DEFAULT 0,
    PRIMARY KEY (codgame, coduser),
    FOREIGN KEY (codgame) REFERENCES GAME(codgame),
    FOREIGN KEY (coduser) REFERENCES GAMEUSER(coduser)
);
```

## 9. Tabela: FRIENDS

* Armazena as conexões sociais e status de solicitações de amizade entre os usuários.

### Dicionário de Dados
| Atributo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `friend_requester` | `INT` | `PRIMARY KEY`, `FK` references `GAMEUSER(coduser)` | Código do usuário que originou o pedido de amizade, referencia o atributo `coduser` na tabela `GAMEUSER`. |
| `friend_receiver` | `INT` | `PRIMARY KEY`, `FK` references `GAMEUSER(coduser)` | Código do usuário destinatário do pedido de amizade, referencia o atributo `coduser` na tabela `GAMEUSER`. |
| `status` | `VARCHAR(50)` | `NOT NULL`, `DEFAULT 'pending'`, `CHECK IN ('pending', 'accepted', 'rejected')` | Situação do pedido de amizade (valores válidos: 'pending', 'accepted', 'rejected'). |

* **Restrição de Integridade Adicional:**
  * `CHECK (friend_requester <> friend_receiver)`: Impede que um usuário envie uma solicitação de amizade para si mesmo.

### Justificativa de Normalização (FNBC)
* **Dependência Funcional (DF):**
  * `(friend_requester, friend_receiver) -> status`
* O único determinante é a chave primária composta `(friend_requester, friend_receiver)`. Como não existem dependências funcionais de atributos não chave e o único determinante é uma superchave, a tabela está em conformidade com a FNBC.

### DDL em PostgreSQL
```sql
CREATE TABLE FRIENDS (
    friend_requester INT,
    friend_receiver INT,
    -- Restrições para o status, o conteudo de status só pode ser pending, accepted ou rejected.
    status VARCHAR(50) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'rejected')),
    PRIMARY KEY (friend_requester, friend_receiver),
    FOREIGN KEY (friend_requester) REFERENCES GAMEUSER(coduser),
    FOREIGN KEY (friend_receiver) REFERENCES GAMEUSER(coduser),
    -- Impede amizante consigo memso.
    CHECK (friend_requester <> friend_receiver) 
);
```

## 10. Tabela: SCREENSHOT

* Armazena as URLs das imagens de captura de tela (screenshots) associadas a cada jogo.

### Dicionário de Dados
| Atributo | Tipo de Dado | Restrições | Descrição |
| :--- | :--- | :--- | :--- |
| `codgame` | `INT` | `PRIMARY KEY`, `FK` references `GAME(codgame)` | Código do jogo ao qual a imagem pertence, referencia o atributo `codgame` na tabela `GAME`. |
| `screenshot_url` | `VARCHAR(250)` | `PRIMARY KEY`, `UNIQUE`, `NOT NULL` | Endereço URL único da imagem de captura de tela. |

### Justificativa de Normalização (FNBC)
* **Dependência Funcional (DF):**
  * `screenshot_url -> codgame`
* O determinante principal na tabela é `screenshot_url` (chave candidata devido à restrição `UNIQUE`). Como o único determinante é uma superchave, a tabela está em conformidade com a Forma Normal de Boyce-Codd (FNBC).

### DDL em PostgreSQL
```sql
CREATE TABLE SCREENSHOT(
    codgame INT,
    screenshot_url VARCHAR(250) UNIQUE NOT NULL,
    PRIMARY KEY (screenshot_url, codgame),
    FOREIGN KEY (codgame) REFERENCES GAME (codgame)
);
```