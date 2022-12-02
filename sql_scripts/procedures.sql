

----------PROCEDURA DODAJ HOTEL-----------------
create or replace PROCEDURE db_user1.dodaj_hotel
(
p_nazwa IN varchar,
p_kraj IN varchar,
p_miasto IN varchar,
p_ulica IN varchar,
p_nr_domu IN number,
p_kod_pocztowy IN varchar,
p_nr_telefonu IN number,
p_mail IN varchar,
p_ocena_gosci IN number,
p_standard IN number
)
AS

BEGIN

    INSERT INTO db_user1.tb_hotele
    VALUES(
        db_user1.sq_hotele_s.NEXTVAL,
        p_nazwa,
        p_kraj,
        p_miasto,
        p_ulica,
        p_nr_domu,
        p_kod_pocztowy,
        p_nr_telefonu,
        p_mail,
        p_ocena_gosci,
        p_standard);

    COMMIT;
END;
/
----------FUNCKJA SPRADŹ CZY ISTNIEJE HOTEL O DANYM ID-----------------

CREATE or REPLACE FUNCTION db_user1.hotel_istnieje(p_id_hotelu in number)
RETURN number
IS
stan number;
ilosc_hotel number;

BEGIN
    SELECT COUNT(*) into ilosc_hotel from db_user1.tb_hotele WHERE p_id_hotelu = id_hotelu;
    IF ilosc_hotel > 0 THEN
    stan := 1;
    ELSE 
    stan := 0;
    END IF;
    return (stan);
END;
/
----------FUNCKJA SPRADŹ CZY ISTNIEJE POKOJ O DANYM ID-----------------

CREATE or REPLACE FUNCTION db_user1.pokoj_istnieje(p_id_pokoju in number)
RETURN number
IS
stan number;
ilosc_pokoj number;

BEGIN
    SELECT COUNT(*) into ilosc_pokoj from db_user1.tb_pokoje_1 WHERE p_id_pokoju = id_pokoju;

    IF ilosc_pokoj > 0 THEN
    stan := 1;

    ELSE 
    SELECT COUNT(*) into ilosc_pokoj from db_user1.tb_pokoje_2 WHERE p_id_pokoju = id_pokoju;
    IF ilosc_pokoj > 0 THEN
    stan := 2;
    ELSE
    stan := 0;
    END IF;

END IF;
    return (stan);
END;

/
----------PROCEDURA DODAJ POKOJ-----------------
CREATE OR REPLACE PROCEDURE db_user1.dodaj_pokoj(
p_id_hotelu number,
p_ilosc_osob number,
p_cena number,
p_standard varchar,
p_opis varchar,
p_dostepny number
)
AS
idx number;
BEGIN
    idx := hotel_istnieje(p_id_hotelu);

    IF idx > 0 THEN
        IF p_id_hotelu = 1 THEN
            INSERT INTO db_user1.tb_pokoje_1
            VALUES(db_user1.sq_pokoje_s.NEXTVAL, p_id_hotelu, p_ilosc_osob, p_cena, p_standard, p_opis, p_dostepny);
        END IF;
        IF p_id_hotelu = 2 THEN
            INSERT INTO db_user1.tb_pokoje_2
            VALUES(db_user1.sq_pokoje_s.NEXTVAL, p_id_hotelu, p_ilosc_osob, p_cena, p_standard, p_opis, p_dostepny);
        END IF;
    END IF;

    COMMIT;
END;

/
----------PROCEDURA DODAJ WYZYWIENIE-----------------
CREATE OR REPLACE PROCEDURE db_user1.dodaj_wyzywienie
(
p_cena in number,
p_typ in  varchar,
p_opis in varchar
)
AS

BEGIN
    INSERT INTO db_user1.tb_wyzywienie
    VALUES(
        db_user1.sq_wyzywienie_s.NEXTVAL,
        p_cena,p_typ,
        p_opis);

    COMMIT;
END;

/
CREATE OR REPLACE FUNCTION db_user1.sprawdz_dostepnosc(p_id_pokoju in number,p_data_od in date,p_data_do in date)
RETURN number
IS
stan number;
ilosc_rezerwacji number;
idx number;
BEGIN
    idx := pokoj_istnieje(p_id_pokoju);
    IF idx = 1 THEN
        SELECT COUNT(*) into ilosc_rezerwacji
        FROM db_user1.tb_rezerwacje_1 WHERE (p_id_pokoju = id_pokoju)
        AND ((data_od > p_data_od and data_od>=p_data_do) or (data_do <= p_data_od and data_do< p_data_do));
    END IF;

    IF idx = 2 THEN
        SELECT COUNT(*) into ilosc_rezerwacji
        FROM db_user1.tb_rezerwacje_2 WHERE (p_id_pokoju = id_pokoju)
        AND ((data_od > p_data_od and data_od>=p_data_do) or (data_do <= p_data_od and data_do< p_data_do));
    END IF;

    IF ilosc_rezerwacji > 0 THEN
    stan := 0;

    ELSE
    stan := 1;

    END IF;

    RETURN (stan);
    END;
/

create or REPLACE PROCEDURE db_user1.dodaj_rezerwacje
(
    p_id_pokoju number,
    p_id_klienta number,
    p_id_wyzywienia number,
    p_data_od date,
    p_data_do date
)

AS
idx number;
hotel_id number;
BEGIN
    idx := pokoj_istnieje(p_id_pokoju);

    IF idx > 0 THEN
        IF sprawdz_dostepnosc(p_id_pokoju,p_data_od,p_data_do) > 0 THEN
            select id_hotelu into hotel_id from db_user1.pokoje where id_pokoju = p_id_pokoju;
            IF hotel_id = 1 THEN
                INSERT INTO db_user1.tb_rezerwacje_1
                VALUES(db_user1.sq_rezerwacje_s.NEXTVAL,p_id_pokoju,p_id_klienta,p_id_wyzywienia,p_data_od,p_data_do);
            END IF;
            IF hotel_id = 2 THEN
                INSERT INTO db_user1.tb_rezerwacje_2
                VALUES(db_user1.sq_rezerwacje_s.NEXTVAL,p_id_pokoju,p_id_klienta,p_id_wyzywienia,p_data_od,p_data_do);
            END IF;
        END IF;
    END IF;
    COMMIT;
END;
/

create or replace PROCEDURE db_user1.dodaj_klienta
(
p_login in varchar,
p_haslo in varchar,
p_imie in varchar,
p_nazwisko in varchar,
p_mail in varchar,
p_nr_telefonu in varchar
)
AS
id number;
BEGIN
    id := db_user1.sq_klient_s.NEXTVAL;
    INSERT INTO db_user1.tb_klienci_podstawowe
    VALUES(id, p_imie,p_nazwisko, p_mail,p_nr_telefonu);

    INSERT INTO db_user1.tb_klienci_logowanie
    VALUES(id, p_login, p_haslo);

    COMMIT;
END;
/