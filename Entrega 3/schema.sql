
drop table if exists local_publico cascade;
drop table if exists item cascade;
drop table if exists anomalia cascade;
drop table if exists anomalia_traducao cascade;
drop table if exists duplicado cascade;
drop table if exists utilizador cascade;
drop table if exists utilizador_qualificado cascade;
drop table if exists utilizador_regular cascade;
drop table if exists incidencia cascade;
drop table if exists proposta_de_correcao cascade;
drop table if exists correcao cascade;

----------------------------------------
-- Table Creation
----------------------------------------

-- Named constraints are global to the database.
-- Therefore the following use the following naming rules:
--   1. pk_table for names of primary key constraints
--   2. fk_table_another for names of foreign key constraints

create table local_publico
   (latitude 	float	not null,
    longitude 	float	not null,
    nome 	varchar(80)	not null,
    constraint pk_local_publico primary key(latitude, longitude));

create table item
   (id 	integer	not null,
    descricao 	varchar(255)	not null,
    localizacao 	varchar(255)	not null,
    latitude 	float	not null,
    longitude 	float	not null,
    assets 		numeric(16,4)	not null,
    constraint pk_item primary key(id),
    constraint fk_item_local_publico foreign key(latitude, longitude) references local_publico(latitude, longitude));

create table anomalia
   (id 	integer	not null,
    zona	varchar(255)	not null,
    imagem 	varchar(255)	not null,
    lingua 	varchar(255)	not null,
    ts 	timestamp	not null,
    descricao 	varchar(255)	not null,
    tem_anomalia_redacao  bit(1)	not null,
    constraint pk_anomalia primary key(id));

create table anomalia_traducao
   (id 	integer	not null,
    zona2	varchar(255)	not null,
    lingua2 	varchar(255)	not null,
    constraint pk_anomalia_traducao primary key(id),
    constraint fk_anomalia_traducao_anomalia foreign key(id) references anomalia(id),
    constraint chk_anomalia_traducao check (zona2 <> (SELECT zona FROM anomalia WHERE id = pk_anomalia_traducao) AND lingua2 <> (SELECT lingua FROM anomalia WHERE id = pk_anomalia_traducao)));

create table duplicado
   (item1 	integer	not null,
    item2 	integer	not null,
    constraint pk_duplicado primary key(item1, item2),
    constraint fk_duplicado_item1 foreign key(item1) references item(id),
    constraint fk_duplicado_item2 foreign key(item2) references item(id));
    --constraint chk_duplicado check (item1 < item2));

create table utilizador
   (email 	varchar(255)	not null,
    passsword	varchar(255) not null, ---deliberate sss as password seems to be a term used by the language
    constraint pk_utilizador primary key(email));

create table utilizador_qualificado
   (email 	varchar(255)	not null,
    constraint pk_utilizador_qualificado primary key(email),
    constraint fk_utilizador_qualificado_utilizador foreign key(email) references utilizador(email),
    constraint chk_utilizador_qualificado check (email NOT IN (SELECT email FROM utilizador_regular)));

create table utilizador_regular
   (email 	varchar(255)	not null,
    constraint pk_utilizador_regular primary key(email),
    constraint fk_utilizador_regular_utilizador foreign key(email) references utilizador(email),
    constraint chk_utilizador_regular check (email NOT IN (SELECT email FROM utilizador_qualificado)));

create table incidencia
   (anomalia_id 	integer not null,
    item_id 	integer not null,
    email 	varchar(255)	not null,
    constraint pk_incidencia primary key(anomalia_id),
    constraint fk_incidencia_anomalia foreign key(anomalia_id) references anomalia(id),
    constraint fk_incidencia_item foreign key(item_id) references item(id),
    constraint fk_incidencia_utilizador foreign key(email) references utilizador(email));

create table proposta_de_correcao
   (email 	varchar(255)	not null,
    nro 	varchar(255)	not null,
    data_text 	datetime	not null,
    texto 	varchar(255)	not null,
    constraint pk_proposta_de_correcao primary key(email, nro),
    constraint fk_proposta_de_correcao_utilizador_qualificado foreign key(email) references utilizador_qualificado(email));

    ---Não percebo a parte em que diz que "email e nro têm de figurar em correcao"

create table correcao
   (email 	varchar(255)	not null,
    nro 	varchar(255)	not null,
    anomalia_id     integer     not null,
    constraint pk_proposta_de_correcao primary key(email, nro, anomalia_id),
    constraint fk_correcao_proposta_de_correcao foreign key(email, nro) references proposta_de_correcao(email, nro),
    constraint fk_correcao_incidencia foreign key (anomalia_id) references incidencia(anomalia_id)); 

----------------------------------------
-- Populate Relations 
----------------------------------------

---insert into customer values ('Adams',	'Main Street',	'Lisbon');