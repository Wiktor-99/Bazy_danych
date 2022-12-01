drop synonym db_user1.sq_hotele_s;
drop synonym db_user1.sq_pokoje_s;
drop synonym db_user1.sq_klient_s;
drop synonym db_user1.sq_rezerwacje_s;
drop synonym db_user1.sq_wyzywienie_s;

create synonym db_user1.sq_hotele_s for db_user1.sq_hotele@orclpdb;
create synonym db_user1.sq_pokoje_s for db_user1.sq_pokoje@orclpdb;
create synonym db_user1.sq_klient_s for db_user1.sq_klient@orclpdb;
create synonym db_user1.sq_rezerwacje_s for db_user1.sq_rezerwacje@orclpdb;
create synonym db_user1.sq_wyzywienie_s for db_user1.sq_wyzywienie@orclpdb;