drop table db_user1.tb_hotele;
drop table db_user1.tb_wyzywienie;


-------------TABELA WYZYWIENIE-----------------
create table db_user1.tb_wyzywienie (
    id_wyzywienia number primary key,
    cena number,
    typ varchar(100),
    opis varchar(150)
);

----------TWORZENIE TABELI HOTELE-----------------
create table db_user1.tb_hotele (
    id_hotelu number primary key,
    nazwa varchar(32) not null,
    kraj varchar(32) not null,
    miasto varchar(32) not null,
    ulica varchar(32) not null,
    nr_domu number not null, 
    kod_pocztowy varchar(32) not null,
    nr_telefonu number not null,
    mail varchar(32) not null,
    ocena_gosci number,
    standard number not null
);

create materialized view log on db_user1.tb_hotele
with primary key
including new values;

create materialized view log on db_user1.tb_wyzywienie
with primary key
including new values;

grant select on db_user1.MLOG$_tb_hotele to db_user1;
grant select on db_user1.MLOG$_tb_wyzywienie to db_user1;
commit;