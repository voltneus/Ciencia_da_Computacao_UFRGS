-- DROPS
DROP VIEW IF EXISTS PUBLIC_GAMEUSER_PROFILE, DEVELOPER_GAMES CASCADE;

-- VISÃO PRUBLICA_GAMEUSER_PROFILE
-- Essa visão consiste em uma tabela com dados públicos de cada usuário GAMEUSER.
-- Apenas são exibidos as colunas:
-- 'username': GAMEUSER.username, é o nome de usuário de cada perfil.
-- 'coduser': GAMEUSER.coduser, é o código de perfil de cada usuário.
-- 'game_list': Essa coluna surge do join entre as tabelas GAMELIBRARY e GAME, na qual o codigo do usuário atual esta em GAMELIBRARY.coduser. O resultado dessa query 
-- é um agrupamento de string que representa a lista de jogos na biblioteca do usuário atual.
-- 'friend_list': Também consiste em um agrupamento de strings, formando uma lista de amigos do usuário atual onde o campo FRIENDS.status = 'accepted'
CREATE VIEW PUBLIC_GAMEUSER_PROFILE as 
SELECT 
    u.username,
    u.coduser,
    -- Lista de jogos do jogador atual em forma de string
    (
        SELECT string_agg(GAME.gamename, ',') 
        FROM GAMELIBRARY lib
        JOIN GAME using (codgame)
        WHERE u.coduser = lib.coduser
    ) as games_list,

    -- Lista de amigos do jogador atual em forma também de string.
    (
        SELECT string_agg(friend.username, ',')
        FROM FRIENDS f 
        JOIN GAMEUSER friend ON 
            -- Caso onde o usuário atual (u) mandou o convite e o amigo recebeu
            (f.friend_requester = u.coduser AND f.friend_receiver = friend.coduser)
            OR
            -- Caso onde o usuário atual (u) recebeu o convite e o amigo mandou
            (f.friend_receiver = u.coduser AND f.friend_requester = friend.coduser)
        WHERE f.status = 'accepted'
    ) AS friends_list

FROM GAMEUSER u;


-- VISÃO DEVELOPER_GAMES
-- Essa visão lista todos os jogos agrupados por desenvolvedora, facilitando
-- para as empresas acompanharem seu catálogo, os preços e a recepção do público
-- (avaliações positivas, negativas e tempo médio jogado).
CREATE VIEW DEVELOPER_GAMES AS
SELECT 
    d.coddev,
    d.devname,
    g.codgame,
    g.gamename,
    g.price,
    g.launch_date,
    g.positive_reviews,
    g.negative_reviews,
    g.average_play_time
FROM DEVELOPER d
JOIN GAMEDEVELOPER gd ON d.coddev = gd.coddev
JOIN GAME g ON gd.codgame = g.codgame;


-- ============================================================================
-- CONSULTAS
-- ============================================================================

-- Consulta 1: Retorna a quantidade de gêneros (tags) distintos associados aos jogos 
-- de cada desenvolvedora, para analisar qual empresa tem o portfólio mais diversificado.
-- Requisitos: Uso de Visão (DEVELOPER_GAMES), GROUP BY, no mínimo 3 tabelas.
SELECT v.devname, COUNT(DISTINCT t.nametag) as qtd_generos
FROM DEVELOPER_GAMES v
JOIN GAMETAG gt ON v.codgame = gt.codgame
JOIN TAG t ON gt.codtag = t.codtag
GROUP BY v.devname;

-- Consulta 2: Lista o nome de usuário e a lista de jogos públicos dos usuários que são
-- muito sociáveis, ou seja, que enviaram ou receberam mais de 1 solicitação de amizade.
-- Requisitos: Uso de Visão (PUBLIC_GAMEUSER_PROFILE), GROUP BY com HAVING, no mínimo 3 tabelas.
SELECT p.username, p.games_list, COUNT(f.friend_receiver) as total_interacoes_amizade
FROM PUBLIC_GAMEUSER_PROFILE p
JOIN GAMEUSER u ON p.coduser = u.coduser
JOIN FRIENDS f ON (u.coduser = f.friend_requester OR u.coduser = f.friend_receiver)
GROUP BY p.username, p.games_list
HAVING COUNT(f.friend_receiver) > 1;

-- Consulta 3: Retorna o nome e e-mail dos usuários que adquiriram o jogo mais caro disponível na loja.
-- Requisitos: Subconsulta que não possui equivalente usando apenas JOIN (agregação MAX).
SELECT u.username, u.email, g.gamename, g.price
FROM GAMEUSER u
JOIN GAMELIBRARY l ON u.coduser = l.coduser
JOIN GAME g ON l.codgame = g.codgame
WHERE g.price = (SELECT MAX(price) FROM GAME);

-- Consulta 4: Retorna os nomes das desenvolvedoras que possuem pelo menos um jogo cujo preço
-- é estritamente maior do que a média de preço global de todos os jogos da plataforma.
-- Requisitos: Subconsulta que não possui equivalente usando apenas JOIN (agregação AVG).
SELECT DISTINCT d.devname, g.gamename, g.price
FROM DEVELOPER d
JOIN GAMEDEVELOPER gd ON d.coddev = gd.coddev
JOIN GAME g ON gd.codgame = g.codgame
WHERE g.price > (SELECT AVG(price) FROM GAME);

-- Consulta 5: Retorna o nome dos usuários que fizeram review de TODOS os jogos desenvolvidos
-- pela 'Rockstar Games'. 
-- Requisitos: Consulta do tipo TODOS (Formulada sobre resultado vazio de diferença/interseção).
SELECT u.username
FROM GAMEUSER u
WHERE NOT EXISTS (
    -- Todos os jogos da Rockstar
    SELECT g.codgame
    FROM GAME g
    JOIN GAMEDEVELOPER gd ON g.codgame = gd.codgame
    JOIN DEVELOPER d ON gd.coddev = d.coddev
    WHERE d.devname = 'Rockstar Games'
    EXCEPT
    -- Jogos que este usuário avaliou
    SELECT r.codgame
    FROM REVIEWS r
    WHERE r.coduser = u.coduser
);

-- Consulta 6: Exibe o nome do jogo, o nome da desenvolvedora e a quantidade de capturas de tela 
-- (screenshots) oficiais disponíveis na página do jogo.
-- Requisitos: GROUP BY simples.
SELECT g.gamename, d.devname, COUNT(s.screenshot_url) as qtd_screenshots
FROM GAME g
JOIN GAMEDEVELOPER gd ON g.codgame = gd.codgame
JOIN DEVELOPER d ON gd.coddev = d.coddev
LEFT JOIN SCREENSHOT s ON g.codgame = s.codgame
GROUP BY g.gamename, d.devname;

-- Consulta 7: Lista os nomes dos jogos do gênero 'RPG', o texto de suas avaliações positivas
-- e o nome de usuário de quem fez a avaliação.
-- Requisitos: Múltiplos JOINs envolvendo 5 tabelas.
SELECT g.gamename, r.review, u.username
FROM TAG t
JOIN GAMETAG gt ON t.codtag = gt.codtag
JOIN GAME g ON gt.codgame = g.codgame
JOIN REVIEWS r ON g.codgame = r.codgame
JOIN GAMEUSER u ON r.coduser = u.coduser
WHERE t.nametag = 'RPG' AND r.ispositive = TRUE;

-- Consulta 8: Retorna o tempo total gasto (em minutos) por cada usuário jogando jogos do 
-- gênero 'Action' em sua respectiva biblioteca.
-- Requisitos: Soma com agrupamento (GROUP BY).
SELECT u.username, SUM(l.playtime) as tempo_total_action_minutos
FROM GAMEUSER u
JOIN GAMELIBRARY l ON u.coduser = l.coduser
JOIN GAME g ON l.codgame = g.codgame
JOIN GAMETAG gt ON g.codgame = gt.codgame
JOIN TAG t ON gt.codtag = t.codtag
WHERE t.nametag = 'Action'
GROUP BY u.username;

-- Consulta 9: Lista jogos lançados a partir do ano de 2018 (lançamentos mais recentes),
-- com o nome da respectiva desenvolvedora e a URL de suas capturas de tela.
-- Requisitos: Múltiplos JOINs com filtragem de datas.
SELECT g.gamename, g.launch_date, d.devname, s.screenshot_url
FROM GAME g
JOIN GAMEDEVELOPER gd ON g.codgame = gd.codgame
JOIN DEVELOPER d ON gd.coddev = d.coddev
JOIN SCREENSHOT s ON g.codgame = s.codgame
WHERE g.launch_date >= '2018-01-01';

-- Consulta 10: Retorna o nome real e o saldo da carteira de usuários que possuem saldo maior 
-- que 100 reais e que possuem solicitações de amizade ativas, evidenciando alto engajamento.
-- Requisitos: Múltiplos JOINs e filtros lógicos.
SELECT DISTINCT u.birth_name, u.wallet_balance
FROM GAMEUSER u
JOIN FRIENDS f ON (u.coduser = f.friend_requester OR u.coduser = f.friend_receiver)
JOIN GAMELIBRARY l ON u.coduser = l.coduser
WHERE u.wallet_balance > 100 AND f.status = 'accepted';
