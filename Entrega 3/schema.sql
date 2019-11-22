----
--drop table local_público cascade;
--drop table item cascade;
--drop table anomalia cascade;
--drop table anomalia_tradução cascade;
--drop table duplicado cascade;
--drop table utilizador cascade;
--drop table utilizador_qualificado cascade;
--drop table utilizador_regular cascade;
--drop table incidência cascade;
--drop table proposta_de_correção cascade;
--drop table correção cascade;
----
----------------------------------------
-- Table Creation
----------------------------------------

-- Named constraints are global to the database.
-- Therefore the following use the following naming rules:
--   1. pk_table for names of primary key constraints
--   2. fk_table_another for names of foreign key constraints

create table local_público
   (latitude 	float	not null,
    longitude 	float	not null,
    nome 	varchar(80)	not null,
    constraint pk_local_público primary key(latitude, longitude));

create table item
   (id 	integer	not null,
    descrição 	varchar(255)	not null,
    localização 	varchar(255)	not null,
    latitude 	float	not null,
    longitude 	float	not null,
    assets 		numeric(16,4)	not null,
    constraint pk_item primary key(id),
    constraint fk_item_local_público foreign key(latitude, longitude) references local_público(latitude, longitude));

create table anomalia
   (id 	integer	not null,
    zona	varchar(255)	not null,
    imagem 	varchar(255)	not null,
    lingua 	varchar(255)	not null,
    ts 	timestamp	not null,
    descrição 	varchar(255)	not null,
    tem_anomalia_redação  bit(1)	not null,
    constraint pk_anomalia primary key(id));

create table anomalia_tradução
   (id 	integer	not null,
    zona2	varchar(255)	not null,
    lingua2 	varchar(255)	not null,
    constraint pk_anomalia_tradução primary key(id),
    constraint fk_anomalia_tradução_anomalia foreign key(id) references anomalia(id),
    constraint chk_anomalia_tradução check (zona2 <> (SELECT zona FROM anomalia WHERE id = pk_anomalia_tradução) AND lingua2 <> (SELECT lingua FROM anomalia WHERE id = pk_anomalia_tradução)));

create table duplicado
   (item1 	integer	not null,
    item2 	integer	not null,
    constraint pk_duplicado primary key(item1, item2),
    constraint fk_duplicado_item foreign key(item1,item2) references item(id),
    constraint chk_duplicado check (item1 < item2));

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

create table incidência
   (anomalia_id 	integer not null,
    item_id 	integer not null,
    email 	varchar(255)	not null,
    constraint pk_incidência primary key(anomalia_id),
    constraint fk_incidência_anomalia foreign key(anomalia_id) references anomalia(id),
    constraint fk_incidência_item foreign key(item_id) references item(id),
    constraint fk_incidência_utilizador foreign key(email) references utilizador(email));

create table proposta_de_correção
   (email 	varchar(255)	not null,
    nro 	varchar(255)	not null,
    data_text 	datetime	not null,
    texto 	varchar(255)	not null,
    constraint pk_proposta_de_correção primary key(email, nro),
    constraint fk_proposta_de_correção_utilizador_qualificado foreign key(email) references utilizador_qualificado(email));

    ---Não percebo a parte em que diz que "email e nro têm de figurar em correção"

create table correção
   (email 	varchar(255)	not null,
    nro 	varchar(255)	not null,
    anomalia_id     integer     not null,
    constraint pk_proposta_de_correção primary key(email, nro, anomalia_id),
    constraint fk_correção_proposta_de_correção foreign key(email, nro) references proposta_de_correção(email, nro),
    constraint fk_correção_incidência foreign key (anomalia_id) references incidência(anomalia_id)); 

----------------------------------------
-- Populate Relations 
----------------------------------------

---insert into customer values ('Adams',	'Main Street',	'Lisbon');