--  local_publico   --

INSERT INTO local_publico VALUES (42.112316,    -55.650346,     'Praca publica');
INSERT INTO local_publico VALUES (78.081231,    -37.823458,     'Rua publica');
INSERT INTO local_publico VALUES (-46.123129,   -53.496863,     'Estrada publica');
INSERT INTO local_publico VALUES (40.232463,    128.521355,     'Predio publico');
INSERT INTO local_publico VALUES (39.336775,    -8.936379,      'Rio Maior'); 
--Esta ultima nao deve ser mudada pois e necessaria para um dos exs de SQL

--  item   --

INSERT INTO item VALUES(42638,  'descricaoItem1',    'localizacaoItem1',    42.112316,  -55.650346);
INSERT INTO item VALUES(48017,  'descricaoItem2',    'localizacaoItem2',    78.081231,  -37.823458);
INSERT INTO item VALUES(63120,  'descricaoItem3',    'localizacaoItem3',    -46.123129, -53.496863);
INSERT INTO item VALUES(39036,  'descricaoItem4',    'localizacaoItem4',    40.232463,  128.521355);
INSERT INTO item VALUES(23466,  'descricaoItem5',    'localizacaoItem5',    40.232463,  128.521355);
INSERT INTO item VALUES(97666,  'descricaoItem6',    'localizacaoItem6',    39.336775,  -8.936379);

--  anomalia   --
-- No lugar da imagem, BYTEA, tem random hexadecimal stuff
-- Coordenadas formato (x1,y1,x2,y2)
INSERT INTO anomalia VALUES(75739,  '(1.2,7.3,6.2,4.2)',    '\\xFFFA12EF',  'portugues',    ('2019-03-07 01:10:04'),    'descricaoAnomalia1',   FALSE);
INSERT INTO anomalia VALUES(84433,  '(2.3,5.6,9.3,2.8)',    '\\x153123EF',  'ingles',       ('2019-04-02 04:02:06'),    'descricaoAnomalia2',   FALSE);
INSERT INTO anomalia VALUES(48651,  '(4.1,9.2,6.1,1.5)',    '\\xDFF12EEF',  'portugues',    ('2019-05-07 20:51:02'),    'descricaoAnomalia3',   FALSE);
INSERT INTO anomalia VALUES(57003,  '(2.5,9.3,5.0,6.4)',    '\\xDEAD1231',  'espanhol',     ('2019-08-16 21:38:03'),    'descricaoAnomalia4',   FALSE);
INSERT INTO anomalia VALUES(90833,  '(3.7,8.1,9.1,3.6)',    '\\xDEA12BCA',  'italiano',     ('2019-09-24 22:29:01'),    'descricaoAnomalia5',   TRUE);

 --  anomalia_traducao   --

INSERT INTO anomalia_traducao VALUES(75739, '(0.5,3.5,7.1,1.5)',    'espanhol');
INSERT INTO anomalia_traducao VALUES(84433, '(6.3,10.2,8.3,5.3)',   'portugues');
INSERT INTO anomalia_traducao VALUES(48651, '(1.3,7.2,3.3,1.8)',    'ingles');
INSERT INTO anomalia_traducao VALUES(57003, '(3.2,6.7,7.1,4.1)',    'ingles');

 --  duplicado   --

INSERT INTO duplicado VALUES(42638, 97666);
INSERT INTO duplicado VALUES(42638, 63120);
INSERT INTO duplicado VALUES(39036, 48017);

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

 --  utilizador_qualificado   --

INSERT INTO utilizador_qualificado VALUES('email_utilizador_qualificado_1@emailorg.com');
INSERT INTO utilizador_qualificado VALUES('email_utilizador_qualificado_2@emailorg.com');
INSERT INTO utilizador_qualificado VALUES('email_utilizador_qualificado_3@emailorg.com');
INSERT INTO utilizador_qualificado VALUES('email_utilizador_qualificado_4@emailorg.com');
INSERT INTO utilizador_qualificado VALUES('email_utilizador_qualificado_5@emailorg.com');
INSERT INTO utilizador_qualificado VALUES('email_utilizador_qualificado_6@emailorg.com');
INSERT INTO utilizador_qualificado VALUES('email_utilizador_qualificado_7@emailorg.com');
INSERT INTO utilizador_qualificado VALUES('email_utilizador_qualificado_8@emailorg.com');

 --  utilizador_regular   --

INSERT INTO utilizador_regular VALUES('email_utilizador_regular_1@emailorg.com');
INSERT INTO utilizador_regular VALUES('email_utilizador_regular_2@emailorg.com');
INSERT INTO utilizador_regular VALUES('email_utilizador_regular_3@emailorg.com');
INSERT INTO utilizador_regular VALUES('email_utilizador_regular_4@emailorg.com');
INSERT INTO utilizador_regular VALUES('email_utilizador_regular_5@emailorg.com');
INSERT INTO utilizador_regular VALUES('email_utilizador_regular_6@emailorg.com');
INSERT INTO utilizador_regular VALUES('email_utilizador_regular_7@emailorg.com');
INSERT INTO utilizador_regular VALUES('email_utilizador_regular_8@emailorg.com');

 --  incidencia   --

INSERT INTO incidencia VALUES(75739,    42638,  'email_utilizador_qualificado_6@emailorg.com');
INSERT INTO incidencia VALUES(84433,    48017,  'email_utilizador_regular_2@emailorg.com');
INSERT INTO incidencia VALUES(48651,    63120,  'email_utilizador_regular_2@emailorg.com');
INSERT INTO incidencia VALUES(57003,    39036,  'email_utilizador_regular_7@emailorg.com');
INSERT INTO incidencia VALUES(90833,    97666,  'email_utilizador_qualificado_8@emailorg.com');

 --  proposta_de_correcao   --

INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_1@emailorg.com',  1,  ('2019-03-07 01:10:04'),    'texto1');
INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_2@emailorg.com',  2,  ('2019-04-02 04:02:06'),    'texto2');
INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_3@emailorg.com',  3,  ('2019-05-07 20:51:02'),    'texto3');
INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_4@emailorg.com',  4,  ('2019-08-16 21:38:03'),    'texto4');
INSERT INTO proposta_de_correcao VALUES('email_utilizador_qualificado_5@emailorg.com',  5,  ('2019-09-24 22:29:01'),    'texto5');

 --  correcao   --

INSERT INTO correcao VALUES('email_utilizador_qualificado_1@emailorg.com',  1,  75739);
INSERT INTO correcao VALUES('email_utilizador_qualificado_2@emailorg.com',  2,  84433);
INSERT INTO correcao VALUES('email_utilizador_qualificado_3@emailorg.com',  3,  48651);
INSERT INTO correcao VALUES('email_utilizador_qualificado_4@emailorg.com',  4,  57003);
INSERT INTO correcao VALUES('email_utilizador_qualificado_5@emailorg.com',  5,  90833);
