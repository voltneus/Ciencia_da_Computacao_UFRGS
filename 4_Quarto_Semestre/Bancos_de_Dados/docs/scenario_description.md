# Simplificação da Steam

## Descrição do Universo de Discurso
Para este trabalho foi modelado o sistema da Steam, uma plataforma digital de distribuição, comércio e comunidade de jogos para computador. O SI atua como ecossistema intermediário que gerencia o catálogo de jogos de desenvolvedores, a biblioteca de jogos dos usuários e a interação entre jogadores.

## Simplificações Realizadas
* **Transações:** Não há um sistema complexo de carrinho de compras ou pagamentos externos. A compra é imediata e é baseada no saldo de uma carteira virtual que o usuário possui.
* **Mídia de um jogo:** Foi desconsiderado qualquer armazenamento de fotos, vídeos ou imagens da comunidade.
* **Tipos de Produtos:** O sistema só gerencia jogos tradicionais. Conteúdo adicional, como softwares ou trilhas sonoras, foi desconsiderado.
* **Idiomas:** O sistema não registra os idiomas disponíveis para o jogo.

---

## Requisitos Informacionais

### Gerenciamento de Atores
* Deve ser possível registrar e manter os dados cadastrais dos usuários, incluindo nome de usuário, nome, e-mail, data de nascimento e saldo da carteira virtual.
* Deve ser possível registrar e manter as empresas desenvolvedoras dos jogos.

### Gerenciamento do Catálogo de Jogos
* Deve ser possível registrar e manter os jogos na plataforma, contendo nome, descrição, preço e data de lançamento.
* Deve ser possível vincular um jogo a uma ou mais desenvolvedoras (visto que jogos podem ser criados em parceria).
* Deve ser possível associar múltiplas categorias/tags (como "Ação", "Corrida", "RPG") a um único jogo, permitindo também que uma tag pertença a vários jogos.

### Interação de Consumo
* Deve ser possível registrar a compra de um jogo por um usuário, adicionando-o automaticamente à sua biblioteca, onde será controlado o tempo de jogo (em minutos) e a data da aquisição.
* Deve ser possível registrar avaliações (reviews) escritas pelos usuários para os jogos que eles conhecem, indicando se a análise é positiva ou negativa e a data da postagem.

### Módulo Social
* Deve ser possível registrar e manter o relacionamento de amizade entre dois usuários da plataforma, controlando o status dessa relação (ex: pendente, aceito).