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