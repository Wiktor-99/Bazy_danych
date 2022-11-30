drop synonym db_user1.sq_hotele;
drop synonym db_user1.sq_pokoje;
drop synonym db_user1.sq_klient;
drop synonym db_user1.sq_rezerwacje;
drop synonym db_user1.sq_wyzywienie;

create synonym db_user1.sq_hotele for db_user1.sq_hotele@orcl1;
create synonym db_user1.sq_pokoje for db_user1.sq_pokoje@orcl1;
create synonym db_user1.sq_klient for db_user1.sq_klient@orcl1;
create synonym db_user1.sq_rezerwacje for db_user1.sq_rezerwacje@orcl1;
create synonym db_user1.sq_wyzywienie for db_user1.sq_wyzywienie@orcl1;