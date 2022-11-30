drop table db_user1.tb_pokoje;
drop table db_user1.tb_klienci_dane_podstawowe;
drop table db_user1.tb_klienci_dane_logowania;
drop view db_user1.tb_klienci;
drop table db_user1.tb_rezerwacje;

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