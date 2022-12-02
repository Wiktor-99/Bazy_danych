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


