

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
    VALUES(db_user1.sq_hotele.NEXTVAL,p_nazwa,p_kraj,p_miasto,p_ulica,p_nr_domu,p_kod_pocztowy,p_nr_telefonu,p_mail,p_ocena_gosci,p_standard);

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
    stan := 0;

    ELSE 
    stan := 1;

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
    SELECT COUNT(*) into ilosc_pokoj from db_user1.tb_pokoje WHERE p_id_pokoju = id_pokoju;

    IF ilosc_pokoj > 0 THEN
    stan := 1;

    ELSE 
    stan := 0;

END IF;
    return (stan);
END;

/
----------PROCEDURA DODAJ POKOJ-----------------
CREATE OR REPLACE PROCEDURE db_user1.add_room(
p_id_hotelu number,
p_ilosc_osob number,
p_cena number,
p_standard varchar,
p_opis varchar,
p_dostepny number
)
AS
BEGIN
    IF hotel_istnieje(p_id_hotelu) > 0 THEN
        INSERT INTO db_user1.tb_pokoje
        VALUES(db_user1.sq_pokoje.NEXTVAL, p_id_hotelu, p_ilosc_osob, p_cena, p_standard, p_opis, p_dostepny);
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
    VALUES(db_user1.sq_wyzywienie.NEXTVAL,p_cena,p_typ,p_opis);

    COMMIT;
END;
/
CREATE OR REPLACE FUNCTION db_user1.sprawdz_dostepnosc(p_id_pokoju in number,p_data_od in date,p_data_do in date)
RETURN number
IS
stan number;
ilosc_rezerwacji number;

BEGIN
    SELECT COUNT(*) into ilosc_rezerwacji
    FROM db_user1.tb_rezerwacje WHERE p_id_pokoju = id_pokoju
    and ((data_od >= p_data_od and data_od<=p_data_do))
    or (data_do >= p_data_od and data_do<= p_data_do);

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
BEGIN
    IF pokoj_istnieje(p_id_pokoju) > 0 and (p_data_od != p_data_do and p_data_do > p_data_od) THEN

    IF sprawdz_dostepnosc(p_id_pokoju,p_data_od,p_data_do) > 0 THEN

    INSERT INTO db_user1.tb_rezerwacje
    VALUES(db_user1.sq_rezerwacje.NEXTVAL,p_id_pokoju,p_id_klienta,p_id_wyzywienia,p_data_od,p_data_do);
    END IF;

    END IF;

    COMMIT;
    END;
/