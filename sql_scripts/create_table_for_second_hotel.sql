drop table db_user1.tb_rezerwacje;
drop table db_user1.tb_klienci_dane_logowania;

-- ----------DANE LOGOWANIA-----------------
create table db_user1.tb_klienci_dane_logowania (
    id_klienta number primary key,
    login varchar(32) unique not null,
    haslo varchar(32) not null
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