--  local_publico   --

INSERT INTO local_publico VALUES (42.112316,    -55.650346,     'Praca publica');
INSERT INTO local_publico VALUES (-13.081231,   -37.823458,     'Rua publica');
INSERT INTO local_publico VALUES (-46.123129,   -53.496863,     'Estrada publica');
INSERT INTO local_publico VALUES (40.232463,    128.521355,     'Predio publico');
INSERT INTO local_publico VALUES (39.336775,    -8.936379,      'Rio Maior');
INSERT INTO local_publico VALUES (12.315582,    -113.825682,    'Museu');
INSERT INTO local_publico VALUES (-63.517234,   -170.091125,    'Pastelaria');
INSERT INTO local_publico VALUES (5.104156,     118.120951,     'Biblioteca');
INSERT INTO local_publico VALUES (-10.123159,    91.134814,     'Restaurante');
INSERT INTO local_publico VALUES (-46.256365,   -149.128911,    'Escola');

--  item   --

INSERT INTO item VALUES(42638,  'descricaoItem1',    'localizacaoItem1',    42.112316,  -55.650346);
INSERT INTO item VALUES(48017,  'descricaoItem2',    'localizacaoItem2',    -13.081231,  -37.823458);
INSERT INTO item VALUES(63120,  'descricaoItem3',    'localizacaoItem3',    -46.123129, -53.496863);
INSERT INTO item VALUES(39036,  'descricaoItem4',    'localizacaoItem4',    40.232463,  128.521355);
INSERT INTO item VALUES(23466,  'descricaoItem5',    'localizacaoItem5',    40.232463,  128.521355);
INSERT INTO item VALUES(97666,  'descricaoItem6',    'localizacaoItem6',    39.336775,  -8.936379);
INSERT INTO item VALUES(52550,  'descricaoItem7',    'localizacaoItem7',    -46.256365, -149.128911);
INSERT INTO item VALUES(65728,  'descricaoItem8',    'localizacaoItem8',    5.104156,   118.120951);
INSERT INTO item VALUES(39296,  'descricaoItem9',    'localizacaoItem9',    -63.517234, -170.091125);
INSERT INTO item VALUES(67703,  'descricaoItem10',   'localizacaoItem10',   40.232463,  128.521355);

--  anomalia   --

INSERT INTO anomalia VALUES(75739,  '((6.2,7.3),(1.2,4.2))',    '\\xFFFA12EF',  'portugues',    ('2019-03-07 01:10:04'),    'descricaoAnomalia1',   FALSE);
INSERT INTO anomalia VALUES(84433,  '((9.3,5.6),(2.3,2.8))',    '\\x153123EF',  'ingles',       ('2019-04-02 04:02:06'),    'descricaoAnomalia2',   FALSE);
INSERT INTO anomalia VALUES(48651,  '((6.1,9.2),(4.1,1.5))',    '\\xDFF12EEF',  'portugues',    ('2019-05-07 20:51:02'),    'descricaoAnomalia3',   FALSE);
INSERT INTO anomalia VALUES(57003,  '((5.0,9.3),(2.5,6.4))',    '\\xDEAD1231',  'espanhol',     ('2019-08-16 21:38:03'),    'descricaoAnomalia4',   FALSE);
INSERT INTO anomalia VALUES(90833,  '((9.1,8.1),(3.7,3.6))',    '\\xDEA12BCA',  'italiano',     ('2018-09-24 22:29:01'),    'descricaoAnomalia5',   TRUE);
INSERT INTO anomalia VALUES(10000,  '((2.3,3.1),(0.3,1.8))',    '\\x63535299',  'espanhol',     ('2019-01-14 14:01:51'),    'descricaoAnomalia6',   TRUE);
INSERT INTO anomalia VALUES(13136,  '((6.3,7.1),(4.6,6.1))',    '\\x17418531',  'italiano',     ('2017-12-05 09:41:17'),    'descricaoAnomalia7',   TRUE);
INSERT INTO anomalia VALUES(81151,  '((7.1,3.6),(6.2,4.1))',    '\\x13894146',  'ingles',       ('2018-02-23 21:42:52'),    'descricaoAnomalia8',   TRUE);
INSERT INTO anomalia VALUES(99350,  '((9.2,4.1),(4.4,3.1))',    '\\x02962095',  'portugues',    ('2019-02-07 13:12:01'),    'descricaoAnomalia9',   TRUE);
INSERT INTO anomalia VALUES(47587,  '((5.2,6.8),(4.6,6.6))',    '\\x29030941',  'espanhol',     ('2019-01-12 17:18:35'),    'descricaoAnomalia10',  TRUE);

 --  anomalia_traducao   --

INSERT INTO anomalia_traducao VALUES(75739, '((7.1,3.5),(0.5,1.5))',    'espanhol');
INSERT INTO anomalia_traducao VALUES(84433, '((8.3,10.2),(6.3,5.8))',   'portugues');
INSERT INTO anomalia_traducao VALUES(48651, '((3.3,7.2),(1.3,1.8))',    'ingles');
INSERT INTO anomalia_traducao VALUES(57003, '((2.3,6.7),(1.7,4.1))',    'ingles');

 --  duplicado   --

INSERT INTO duplicado VALUES(42638, 97666);
INSERT INTO duplicado VALUES(42638, 63120);
INSERT INTO duplicado VALUES(39296, 48017);
INSERT INTO duplicado VALUES(39036, 97666);
INSERT INTO duplicado VALUES(23466, 52550);
INSERT INTO duplicado VALUES(65728, 67703);

 --  utilizador   --

INSERT INTO utilizador VALUES('email_utilizador_qualificado_1@emailorg.com',    'password_utilizador_qualificado_1');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_2@emailorg.com',    'password_utilizador_qualificado_2');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_3@emailorg.com',    'password_utilizador_qualificado_3');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_4@emailorg.com',    'password_utilizador_qualificado_4');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_5@emailorg.com',    'password_utilizador_qualificado_5');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_6@emailorg.com',    'password_utilizador_qualificado_6');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_7@emailorg.com',    'password_utilizador_qualificado_7');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_8@emailorg.com',    'password_utilizador_qualificado_8');

INSERT INTO utilizador VALUES('email_utilizador_regular_1@emailorg.com',    'password_utilizador_regular_1');
INSERT INTO utilizador VALUES('email_utilizador_regular_2@emailorg.com',    'password_utilizador_regular_2');
INSERT INTO utilizador VALUES('email_utilizador_regular_3@emailorg.com',    'password_utilizador_regular_3');
INSERT INTO utilizador VALUES('email_utilizador_regular_4@emailorg.com',    'password_utilizador_regular_4');
INSERT INTO utilizador VALUES('email_utilizador_regular_5@emailorg.com',    'password_utilizador_regular_5');
INSERT INTO utilizador VALUES('email_utilizador_regular_6@emailorg.com',    'password_utilizador_regular_6');
INSERT INTO utilizador VALUES('email_utilizador_regular_7@emailorg.com',    'password_utilizador_regular_7');
INSERT INTO utilizador VALUES('email_utilizador_regular_8@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_11@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_12@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_13@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_14@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_15@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_16@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_17@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_18@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_21@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_22@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_23@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_24@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_25@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_26@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_27@emailorg.com',    'password_utilizador_regular_8');
INSERT INTO utilizador VALUES('email_utilizador_qualificado_28@emailorg.com',    'password_utilizador_regular_8');

 --  utilizador_qualificado   --

-- Adicionar entradas ao utilizador qualificado é feito no trigger causado pela remoção de utilizadores regulares, para impedir
-- um utilizador de ser regular e qualificado ao mesmo tempo e também impedir que um utilizador não seja regular ou qualificado.

DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_1@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_2@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_3@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_4@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_5@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_6@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_7@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_8@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_11@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_12@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_13@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_14@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_15@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_16@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_17@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_18@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_21@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_22@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_23@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_24@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_25@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_26@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_27@emailorg.com';
DELETE FROM utilizador_regular WHERE email = 'email_utilizador_qualificado_28@emailorg.com';

 --  incidencia   --

INSERT INTO incidencia VALUES(75739,    42638,  'email_utilizador_qualificado_6@emailorg.com');
INSERT INTO incidencia VALUES(10000,    48017,  'email_utilizador_qualificado_2@emailorg.com');
INSERT INTO incidencia VALUES(84433,    48017,  'email_utilizador_regular_2@emailorg.com');
INSERT INTO incidencia VALUES(48651,    63120,  'email_utilizador_qualificado_2@emailorg.com');
INSERT INTO incidencia VALUES(57003,    39036,  'email_utilizador_qualificado_6@emailorg.com');
INSERT INTO incidencia VALUES(90833,    39296,  'email_utilizador_regular_7@emailorg.com');
INSERT INTO incidencia VALUES(99350,    65728,  'email_utilizador_qualificado_3@emailorg.com');
INSERT INTO incidencia VALUES(81151,    23466,  'email_utilizador_regular_5@emailorg.com');

 --  proposta_de_correcao   --

INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_1@emailorg.com',  1,  ('2019-03-07 01:10:04'),    'texto1');
INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_2@emailorg.com',  1,  ('2019-04-02 04:02:06'),    'texto2');
INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_3@emailorg.com',  1,  ('2019-05-07 20:51:02'),    'texto3');
INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_4@emailorg.com',  1,  ('2019-08-16 21:38:03'),    'texto4');
INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_5@emailorg.com',  1,  ('2019-09-24 22:29:01'),    'texto5');
INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_6@emailorg.com',  1,  ('2019-05-24 05:12:12'),    'texto6');
INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_1@emailorg.com',  2,  ('2019-08-24 21:33:45'),    'texto7');
INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_2@emailorg.com',  2,  ('2019-11-24 12:55:21'),    'texto8');

 --  correcao   --

INSERT INTO correcao VALUES('email_utilizador_qualificado_1@emailorg.com',  1,  75739);
INSERT INTO correcao VALUES('email_utilizador_qualificado_2@emailorg.com',  1,  48651);
INSERT INTO correcao VALUES('email_utilizador_qualificado_3@emailorg.com',  1,  84433);
INSERT INTO correcao VALUES('email_utilizador_qualificado_4@emailorg.com',  1,  57003);
INSERT INTO correcao VALUES('email_utilizador_qualificado_5@emailorg.com',  1,  90833);
INSERT INTO correcao VALUES('email_utilizador_qualificado_6@emailorg.com',  1,  75739);
INSERT INTO correcao VALUES('email_utilizador_qualificado_1@emailorg.com',  2,  81151);
INSERT INTO correcao VALUES('email_utilizador_qualificado_2@emailorg.com',  2,  99350);