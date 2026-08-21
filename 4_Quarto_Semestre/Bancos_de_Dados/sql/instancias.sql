-- Game:
INSERT INTO GAME VALUES (DEFAULT, 'Forza Horizon 6', 250, 'Discover landscapes of Japan and become a racing Legend', '2026-08-03');
INSERT INTO GAME VALUES (DEFAULT, 'The Witcher 3', 150, 'You are Geralt of Rivia, mercenary monster slayer.', '2015-03-11');
INSERT INTO GAME VALUES (DEFAULT, 'Stardew Valley', 35, 'You''ve inherited your grandfather''s old farm plot in Stardew Valley.', '2016-02-26');
INSERT INTO GAME VALUES (DEFAULT, 'Cyberpunk 2077', 200, 'Cyberpunk 2077 is an open-world, action-adventure RPG set in the megalopolis of Night City.', '2020-12-10');
INSERT INTO GAME VALUES (DEFAULT, 'Hollow Knight', 50, 'Forge your own path in Hollow Knight! An epic action adventure through a vast ruined kingdom.', '2017-02-24');
INSERT INTO GAME VALUES (DEFAULT, 'Elden Ring', 250, 'Rise, Tarnished, and be guided by grace to brandish the power of the Elden Ring.', '2022-02-25');
INSERT INTO GAME VALUES (DEFAULT, 'Dark Souls III', 150, 'As fires fade and the world falls into ruin, journey into a universe filled with colossal enemies.', '2016-04-11');
INSERT INTO GAME VALUES (DEFAULT, 'Grand Theft Auto V', 80, 'When a young street hustler, a retired bank robber and a terrifying psychopath find themselves entangled...', '2015-04-14');
INSERT INTO GAME VALUES (DEFAULT, 'Red Dead Redemption 2', 200, 'Winner of over 175 Game of the Year Awards and recipient of over 250 perfect scores.', '2019-11-05');
INSERT INTO GAME VALUES (DEFAULT, 'Assassin''s Creed Valhalla', 200, 'Become Eivor, a legendary Viking raider on a quest for glory.', '2020-11-10');
INSERT INTO GAME VALUES (DEFAULT, 'Far Cry 6', 250, 'Welcome to Yara, a tropical paradise frozen in time.', '2021-10-07');
INSERT INTO GAME VALUES (DEFAULT, 'Tom Clancy''s Rainbow Six Siege', 60, 'Master the art of destruction and gadgetry in highly intense, close-quarters combat.', '2015-12-01');

-- Developer:
INSERT INTO DEVELOPER VALUES (DEFAULT, 'Playground Games');
INSERT INTO DEVELOPER VALUES (DEFAULT, 'CD Project Red');
INSERT INTO DEVELOPER VALUES (DEFAULT, 'ConcernedApe');
INSERT INTO DEVELOPER VALUES (DEFAULT, 'Team Cherry');
INSERT INTO DEVELOPER VALUES (DEFAULT, 'FromSoftware');
INSERT INTO DEVELOPER VALUES (DEFAULT, 'Rockstar Games');
INSERT INTO DEVELOPER VALUES (DEFAULT, 'Ubisoft');

-- User:
INSERT INTO GAMEUSER VALUES (DEFAULT, 'joãozinGamer', 'joaogames@gmail.com', crypt('senhaJoao123', gen_salt('bf')), 200, '2006-11-07', 'João Santos');
INSERT INTO GAMEUSER VALUES (DEFAULT, 'mariaJogos', 'maria@gmail.com', crypt('mariaSenha456', gen_salt('bf')), 400, '2003-05-28', 'Maria Silva');
INSERT INTO GAMEUSER VALUES (DEFAULT, 'proGamer99', 'progamer99@gmail.com', crypt('carlosSenha789', gen_salt('bf')), 50, '1999-01-15', 'Carlos Oliveira');
INSERT INTO GAMEUSER VALUES (DEFAULT, 'ana_indie', 'ana.indie@gmail.com', crypt('anaSenha101', gen_salt('bf')), 150, '2001-08-22', 'Ana Souza');
INSERT INTO GAMEUSER VALUES (DEFAULT, 'lucas_rpg', 'lucasrpg@gmail.com', crypt('lucasSenha112', gen_salt('bf')), 30, '1995-12-10', 'Lucas Lima');

-- Tag:
INSERT INTO TAG VALUES (DEFAULT, 'Adventure');
INSERT INTO TAG VALUES (DEFAULT, 'Racing');
INSERT INTO TAG VALUES (DEFAULT, 'Open world');
INSERT INTO TAG VALUES (DEFAULT, 'RPG');
INSERT INTO TAG VALUES (DEFAULT, 'Simulation');
INSERT INTO TAG VALUES (DEFAULT, 'Metroidvania');
INSERT INTO TAG VALUES (DEFAULT, 'Action');
INSERT INTO TAG VALUES (DEFAULT, 'Souls-like');
INSERT INTO TAG VALUES (DEFAULT, 'FPS');
INSERT INTO TAG VALUES (DEFAULT, 'Stealth');

-- GameDeveloper:
INSERT INTO GAMEDEVELOPER VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Forza Horizon 6'), (SELECT coddev FROM DEVELOPER WHERE devname = 'Playground Games'));
INSERT INTO GAMEDEVELOPER VALUES ((SELECT codgame FROM GAME WHERE gamename = 'The Witcher 3'), (SELECT coddev FROM DEVELOPER WHERE devname = 'CD Project Red'));
INSERT INTO GAMEDEVELOPER VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Stardew Valley'), (SELECT coddev FROM DEVELOPER WHERE devname = 'ConcernedApe'));
INSERT INTO GAMEDEVELOPER VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Cyberpunk 2077'), (SELECT coddev FROM DEVELOPER WHERE devname = 'CD Project Red'));
INSERT INTO GAMEDEVELOPER VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Hollow Knight'), (SELECT coddev FROM DEVELOPER WHERE devname = 'Team Cherry'));
INSERT INTO GAMEDEVELOPER VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Elden Ring'), (SELECT coddev FROM DEVELOPER WHERE devname = 'FromSoftware'));
INSERT INTO GAMEDEVELOPER VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Dark Souls III'), (SELECT coddev FROM DEVELOPER WHERE devname = 'FromSoftware'));
INSERT INTO GAMEDEVELOPER VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Grand Theft Auto V'), (SELECT coddev FROM DEVELOPER WHERE devname = 'Rockstar Games'));
INSERT INTO GAMEDEVELOPER VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Red Dead Redemption 2'), (SELECT coddev FROM DEVELOPER WHERE devname = 'Rockstar Games'));
INSERT INTO GAMEDEVELOPER VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Assassin''s Creed Valhalla'), (SELECT coddev FROM DEVELOPER WHERE devname = 'Ubisoft'));
INSERT INTO GAMEDEVELOPER VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Far Cry 6'), (SELECT coddev FROM DEVELOPER WHERE devname = 'Ubisoft'));
INSERT INTO GAMEDEVELOPER VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Tom Clancy''s Rainbow Six Siege'), (SELECT coddev FROM DEVELOPER WHERE devname = 'Ubisoft'));

-- GameTag:
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Forza Horizon 6'), (SELECT codtag FROM TAG WHERE nametag = 'Racing'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Forza Horizon 6'), (SELECT codtag FROM TAG WHERE nametag = 'Open world'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'The Witcher 3'), (SELECT codtag FROM TAG WHERE nametag = 'Adventure'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'The Witcher 3'), (SELECT codtag FROM TAG WHERE nametag = 'Open world'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'The Witcher 3'), (SELECT codtag FROM TAG WHERE nametag = 'RPG'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Stardew Valley'), (SELECT codtag FROM TAG WHERE nametag = 'RPG'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Stardew Valley'), (SELECT codtag FROM TAG WHERE nametag = 'Simulation'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Cyberpunk 2077'), (SELECT codtag FROM TAG WHERE nametag = 'RPG'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Cyberpunk 2077'), (SELECT codtag FROM TAG WHERE nametag = 'Action'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Cyberpunk 2077'), (SELECT codtag FROM TAG WHERE nametag = 'Open world'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Hollow Knight'), (SELECT codtag FROM TAG WHERE nametag = 'Action'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Hollow Knight'), (SELECT codtag FROM TAG WHERE nametag = 'Adventure'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Hollow Knight'), (SELECT codtag FROM TAG WHERE nametag = 'Metroidvania'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Elden Ring'), (SELECT codtag FROM TAG WHERE nametag = 'RPG'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Elden Ring'), (SELECT codtag FROM TAG WHERE nametag = 'Action'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Elden Ring'), (SELECT codtag FROM TAG WHERE nametag = 'Open world'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Elden Ring'), (SELECT codtag FROM TAG WHERE nametag = 'Souls-like'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Dark Souls III'), (SELECT codtag FROM TAG WHERE nametag = 'RPG'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Dark Souls III'), (SELECT codtag FROM TAG WHERE nametag = 'Action'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Dark Souls III'), (SELECT codtag FROM TAG WHERE nametag = 'Souls-like'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Grand Theft Auto V'), (SELECT codtag FROM TAG WHERE nametag = 'Action'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Grand Theft Auto V'), (SELECT codtag FROM TAG WHERE nametag = 'Open world'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Red Dead Redemption 2'), (SELECT codtag FROM TAG WHERE nametag = 'Action'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Red Dead Redemption 2'), (SELECT codtag FROM TAG WHERE nametag = 'Open world'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Red Dead Redemption 2'), (SELECT codtag FROM TAG WHERE nametag = 'Adventure'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Assassin''s Creed Valhalla'), (SELECT codtag FROM TAG WHERE nametag = 'Action'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Assassin''s Creed Valhalla'), (SELECT codtag FROM TAG WHERE nametag = 'RPG'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Assassin''s Creed Valhalla'), (SELECT codtag FROM TAG WHERE nametag = 'Open world'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Assassin''s Creed Valhalla'), (SELECT codtag FROM TAG WHERE nametag = 'Stealth'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Far Cry 6'), (SELECT codtag FROM TAG WHERE nametag = 'Action'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Far Cry 6'), (SELECT codtag FROM TAG WHERE nametag = 'FPS'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Far Cry 6'), (SELECT codtag FROM TAG WHERE nametag = 'Open world'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Tom Clancy''s Rainbow Six Siege'), (SELECT codtag FROM TAG WHERE nametag = 'Action'));
INSERT INTO GAMETAG VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Tom Clancy''s Rainbow Six Siege'), (SELECT codtag FROM TAG WHERE nametag = 'FPS'));

-- Reviews:
INSERT INTO REVIEWS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'joãozinGamer'), (SELECT codgame FROM GAME WHERE gamename = 'The Witcher 3'), 't', 'muito bom o jogo');
INSERT INTO REVIEWS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'ana_indie'), (SELECT codgame FROM GAME WHERE gamename = 'Stardew Valley'), 't', 'Relaxante e viciante!');
INSERT INTO REVIEWS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'lucas_rpg'), (SELECT codgame FROM GAME WHERE gamename = 'Cyberpunk 2077'), 't', 'Ótimos gráficos e história.');
INSERT INTO REVIEWS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'proGamer99'), (SELECT codgame FROM GAME WHERE gamename = 'Hollow Knight'), 't', 'Obra prima!');
INSERT INTO REVIEWS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'joãozinGamer'), (SELECT codgame FROM GAME WHERE gamename = 'Grand Theft Auto V'), 't', 'Jogo muito divertido com os amigos.');
INSERT INTO REVIEWS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'mariaJogos'), (SELECT codgame FROM GAME WHERE gamename = 'Elden Ring'), 'f', 'Muito difícil, morri 100 vezes no primeiro boss.');
INSERT INTO REVIEWS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'lucas_rpg'), (SELECT codgame FROM GAME WHERE gamename = 'Red Dead Redemption 2'), 't', 'História maravilhosa, me fez chorar.');
INSERT INTO REVIEWS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'joãozinGamer'), (SELECT codgame FROM GAME WHERE gamename = 'Tom Clancy''s Rainbow Six Siege'), 't', 'Jogo muito tático, gosto de jogar com o esquadrão.');
INSERT INTO REVIEWS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'ana_indie'), (SELECT codgame FROM GAME WHERE gamename = 'Assassin''s Creed Valhalla'), 'f', 'Mundo muito grande e vazio, missões repetitivas.');

-- Library:
INSERT INTO GAMELIBRARY VALUES ((SELECT codgame FROM GAME WHERE gamename = 'The Witcher 3'), (SELECT coduser FROM GAMEUSER WHERE username = 'joãozinGamer'), DEFAULT, 100);
INSERT INTO GAMELIBRARY VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Hollow Knight'), (SELECT coduser FROM GAMEUSER WHERE username = 'proGamer99'), DEFAULT, 1500);
INSERT INTO GAMELIBRARY VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Cyberpunk 2077'), (SELECT coduser FROM GAMEUSER WHERE username = 'proGamer99'), DEFAULT, 3000);
INSERT INTO GAMELIBRARY VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Stardew Valley'), (SELECT coduser FROM GAMEUSER WHERE username = 'ana_indie'), DEFAULT, 5000);
INSERT INTO GAMELIBRARY VALUES ((SELECT codgame FROM GAME WHERE gamename = 'The Witcher 3'), (SELECT coduser FROM GAMEUSER WHERE username = 'lucas_rpg'), DEFAULT, 4000);
INSERT INTO GAMELIBRARY VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Grand Theft Auto V'), (SELECT coduser FROM GAMEUSER WHERE username = 'joãozinGamer'), DEFAULT, 12000);
INSERT INTO GAMELIBRARY VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Elden Ring'), (SELECT coduser FROM GAMEUSER WHERE username = 'mariaJogos'), DEFAULT, 300);
INSERT INTO GAMELIBRARY VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Dark Souls III'), (SELECT coduser FROM GAMEUSER WHERE username = 'proGamer99'), DEFAULT, 4500);
INSERT INTO GAMELIBRARY VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Red Dead Redemption 2'), (SELECT coduser FROM GAMEUSER WHERE username = 'lucas_rpg'), DEFAULT, 8000);
INSERT INTO GAMELIBRARY VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Tom Clancy''s Rainbow Six Siege'), (SELECT coduser FROM GAMEUSER WHERE username = 'joãozinGamer'), DEFAULT, 25000);
INSERT INTO GAMELIBRARY VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Assassin''s Creed Valhalla'), (SELECT coduser FROM GAMEUSER WHERE username = 'ana_indie'), DEFAULT, 3500);
INSERT INTO GAMELIBRARY VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Far Cry 6'), (SELECT coduser FROM GAMEUSER WHERE username = 'lucas_rpg'), DEFAULT, 2000);

-- Friends:
INSERT INTO FRIENDS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'joãozinGamer'), (SELECT coduser FROM GAMEUSER WHERE username = 'mariaJogos'), 'accepted');
INSERT INTO FRIENDS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'proGamer99'), (SELECT coduser FROM GAMEUSER WHERE username = 'lucas_rpg'), 'accepted');
INSERT INTO FRIENDS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'ana_indie'), (SELECT coduser FROM GAMEUSER WHERE username = 'mariaJogos'), 'accepted');
INSERT INTO FRIENDS VALUES ((SELECT coduser FROM GAMEUSER WHERE username = 'proGamer99'), (SELECT coduser FROM GAMEUSER WHERE username = 'joãozinGamer'), 'pending');

-- Screenshots:
INSERT INTO SCREENSHOT VALUES ((SELECT codgame FROM GAME WHERE gamename = 'The Witcher 3'), 'https://example.com/witcher3_screen1.jpg');
INSERT INTO SCREENSHOT VALUES ((SELECT codgame FROM GAME WHERE gamename = 'The Witcher 3'), 'https://example.com/witcher3_screen2.jpg');
INSERT INTO SCREENSHOT VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Hollow Knight'), 'https://example.com/hollow_knight_screen1.jpg');
INSERT INTO SCREENSHOT VALUES ((SELECT codgame FROM GAME WHERE gamename = 'Elden Ring'), 'https://example.com/elden_ring_boss.png');