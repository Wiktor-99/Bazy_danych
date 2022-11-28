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
----------SEKWENCJA DLA HOTELI-----------------
CREATE SEQUENCE db_user1.sq_hotele
MINVALUE 0
START WITH 1
INCREMENT BY 1
NOCACHE NOORDER NOCYCLE NOKEEP NOSCALE GLOBAL

----------PROCEDURA DODAJ HOTEL-----------------
CREATE OR REPLACE PROCEDURE db_user1.dodaj_hotel
(
_nazwa IN varchar,
_kraj IN varchar,
_miasto,_ulica IN varchar,
_nr_domu IN number,
_kod_pocztowy IN varchar,
_nr_telefonu IN number,
_mail IN varchar,
_ocena_gosci IN number
)
AS

BEGIN

    INSERT INTO db_user1.tb_hotele
    VALUES(db_user1.sq_hotele.NEXTVAL,_nazwa,_kraj,_miasto,_ulica,_nr_domu,_kod_pocztowy,_nr_telefonu,_mail,_ocena_gosci);

    COMMIT;
END;

----------FUNCKJA SPRADŹ CZY ISTNIEJE HOTEL O DANYM ID-----------------

CREATE or REPLACE FUNCTION hotel_istnieje(_id_hotelu in number)
RETURN number
IS
stan number;
ilosc_hotel number;

BEGIN
    SELECT COUNT(*) into ilosc_hotel from db_user1.tb_hotele WHERE _id_hotelu = id_hotelu;

    IF ilosc_hotel > 0 THEN
    stan := 1;

    ELSE 
    stan := 0;

END IF;
    return (stan);
END;




----------TWORZENIE TABELI POKOJE-----------------
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

----------SEKWENCJA DLA POKOI-----------------
CREATE SEQUENCE db_user1.sq_pokoje
MINVALUE 0
START WITH 1
INCREMENT BY 1
NOCACHE NOORDER NOCYCLE NOKEEP NOSCALE GLOBAL


----------FUNCKJA SPRADŹ CZY ISTNIEJE POKOJ O DANYM ID-----------------

CREATE or REPLACE FUNCTION pokoj_istnieje(_id_pokoju in number)
RETURN number
IS
stan number;
ilosc_pokoj number;

BEGIN
    SELECT COUNT(*) into ilosc_pokoj from db_user1.tb_pokoje WHERE _id_pokoju = id_pokoju;

    IF ilosc_pokoj > 0 THEN
    stan := 1;

    ELSE 
    stan := 0;

END IF;
    return (stan);
END;


----------PROCEDURA DODAJ POKOJ-----------------
CREATE OR REPLACE PROCEDURE db_user1.add_room(
_id_hotelu number,
_ilosc_osob number,
_cena number,
_opis varchar,
_dostepny number
)
AS
BEGIN
    IF hotel_istnieje(_id_hotelu) THEN
        INSERT INTO db_user1.tb_pokoje
        VALUES(db_user1.sq_pokoje.NEXTVAL,_id_pokoju,_id_hotelu,_ilosc_osob,_cena,_opis,_dostepny)
    END IF;

    COMMIT;
END;

----------TWORZENIE TABELI DLA KLIENTÓW-----------------
----------DANE PODSTAWOWE-----------------
create table db_user1.tb_klienci_dane_podstawowe (
    id_klienta number primary key,
    imie varchar(32) not null,
    nazwisko varchar(32) not null,
    mail varchar(32) unique not null,
    nr_telefonu varchar(32) unique not null
);
----------DANE LOGOWANIA-----------------
create table db_user1.tb_klienci_dane_logowania (
    id_klienta number primary key,
    login varchar(32) unique not null,
    haslo varchar(32) not null
);

create view db_user1.tb_klienci as 
select db_user1.tb_klienci_dane_podstawowe.*, db_user1.tb_klienci_dane_logowania.login, db_user1.tb_klienci_dane_logowania.haslo
from db_user1.tb_klienci_dane_logowania FULL join db_user1.tb_klienci_dane_podstawowe
on db_user1.tb_klienci_dane_podstawowe.id_klienta = db_user1.tb_klienci_dane_logowania.id_klienta;

create table db_user1.tb_wyzywienie (
    id_wyzywienia number primary key,
    cena number,
    typ varchar(100),
    opis varchar(150)
);


----------SEKWENCJA DLA WYZYWIENIA-----------------
CREATE SEQUENCE db_user1.sq_wyzywienie
MINVALUE 0
START WITH 1
INCREMENT BY 1
NOCACHE NOORDER NOCYCLE NOKEEP NOSCALE GLOBAL

----------PROCEDURA DODAJ WYZYWIENIE-----------------
CREATE OR REPLACE PROCEDURE db_user1.dodaj_wyzywienie
(
_cena in number,
_typ in  varchar(100),
_opis in varchar(150)
)
AS

BEGIN
    INSERT INTO db_user1.sq_wyzywienie
    VALUES(db_user1.sq_wyzywienie.NEXTVAL,_cena,_typ,_opis);

    COMMIT;
END;



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


----------SEKWENCJA DLA REZERWACJE-----------------
CREATE SEQUENCE db_user1.sq_rezerwacje
MINVALUE 0
START WITH 1
INCREMENT BY 1
NOCACHE NOORDER NOCYCLE NOKEEP NOSCALE GLOBAL

CREATE OR REPLACE FUNCTION sprawdz_dostepnosc(_id_pokoju in number,_data_od in date,_data_do in date)
RETURN number
IS
stan number;
ilosc_rezerwacji number;

BEGIN
    SELECT COUNT(*) into ilosc_rezerwacji
    FROM db_user1.tb_rezerwacje WHERE _id_pokoju = id_pokoju
    and ((data_od >= _data_od and data_od<=_data_do))
    or (data_do >= _data_od and data_do<= _data_do)

    IF ilosc_rezerwacji > 0 THEN
    stan := 0;

    ELSE
    stan:=1;

    END IF;

    RETURN (STAN);
    END;


create or REPLACE PROCEDURE dodaj_rezerwacje
(
    _id_pokoju number,
    _id_klienta number,
    _id_wyzywienia number,
    _data_od date,
    _data_do date
)

AS
BEGIN
    IF pokoj_istnieje(_id_pokoju) and (_data_od != _data_do and _data_do > _data_od) THEN

    IF sprawdz_dostepnosc(_id_pokoju,_data_od,_data_do) = 1 THEN

    INSERT INTO db_user1.tb_rezerwacje
    VALUES(db_user1.sq_rezerwacje.NEXTVAL,_id_pokoju,_id_klienta,_id_wyzywienia,_data_od,_data_do)
    END IF;

    END IF;

    COMMIT;
    END;