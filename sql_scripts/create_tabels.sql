drop sequence db_user1.sq_hotele;
drop sequence db_user1.sq_pokoje;
drop sequence db_user1.sq_klient;
drop sequence db_user1.sq_rezerwacje;
drop sequence db_user1.sq_wyzywienie;

create sequence db_user1.sq_hotele start with 1 increment by 1;
create sequence db_user1.sq_pokoje start with 1 increment by 1;
create sequence db_user1.sq_klient start with 1 increment by 1;
create sequence db_user1.sq_rezerwacje start with 1 increment by 1;
create sequence db_user1.sq_wyzywienie start with 1 increment by 1;


drop table db_user1.tb_pokoje;
drop table db_user1.tb_hotele;
drop table db_user1.tb_klienci_dane_podstawowe;
drop table db_user1.tb_klienci_dane_logowania;
drop view db_user1.tb_klienci;
drop table db_user1.tb_wyzywienie;
drop table db_user1.tb_rezerwacje;

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

-- ----------TWORZENIE TABELI POKOJE-----------------
create table db_user1.tb_pokoje (
    id_pokoju number primary key,
    id_hotelu number not null,
    ilosc_osob number not null,
    cena number not null,
    standard varchar(32) not null,
    opis varchar(200),
    dostepny number(1) not null,
    constraint fk_id_hotelu foreign key (id_hotelu) references db_user1.tb_hotele (id_hotelu)
);


-- ----------TWORZENIE TABELI DLA KLIENTÓW-----------------
-- ----------DANE PODSTAWOWE-----------------
create table db_user1.tb_klienci_dane_podstawowe (
    id_klienta number primary key,
    imie varchar(32) not null,
    nazwisko varchar(32) not null,
    mail varchar(32) unique not null,
    nr_telefonu varchar(32) unique not null
);
-- ----------DANE LOGOWANIA-----------------
create table db_user1.tb_klienci_dane_logowania (
    id_klienta number primary key,
    login varchar(32) unique not null,
    haslo varchar(32) not null
);

create view db_user1.tb_klienci as 
select db_user1.tb_klienci_dane_podstawowe.*, db_user1.tb_klienci_dane_logowania.login, db_user1.tb_klienci_dane_logowania.haslo
from db_user1.tb_klienci_dane_logowania FULL join db_user1.tb_klienci_dane_podstawowe
on db_user1.tb_klienci_dane_podstawowe.id_klienta = db_user1.tb_klienci_dane_logowania.id_klienta;


-- ----------TABELA WYZYWIENIE-----------------
create table db_user1.tb_wyzywienie (
    id_wyzywienia number primary key,
    cena number,
    typ varchar(100),
    opis varchar(150)
);
-- ----------TABELA REZERWACJE-----------------
create table db_user1.tb_rezerwacje (
    id_rezerwacji number primary key,
    id_pokoju number not null,
    id_klienta number not null,
    id_wyzywienia number not null,
    data_od date not null,
    data_do date not null,
    constraint fk_id_pokoju foreign key (id_pokoju) references db_user1.tb_pokoje (id_pokoju),
    constraint fk_id_klienta foreign key (id_klienta) references db_user1.tb_klienci_dane_logowania (id_klienta),
    constraint fk_id_wyzywienia foreign key (id_wyzywienia) references db_user1.tb_wyzywienie (id_wyzywienia)
);