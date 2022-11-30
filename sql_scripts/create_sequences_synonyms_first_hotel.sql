drop synonym db_user1.sq_hotele_s;
drop synonym db_user1.sq_pokoje_s;
drop synonym db_user1.sq_klient_s;
drop synonym db_user1.sq_rezerwacje_s;
drop synonym db_user1.sq_wyzywienie_s;

create synonym db_user1.sq_hotele_s for db_user1.sq_hotele;
create synonym db_user1.sq_pokoje_s for db_user1.sq_pokoje;
create synonym db_user1.sq_klient_s for db_user1.sq_klient;
create synonym db_user1.sq_rezerwacje_s for db_user1.sq_rezerwacje;
create synonym db_user1.sq_wyzywienie_s for db_user1.sq_wyzywienie;