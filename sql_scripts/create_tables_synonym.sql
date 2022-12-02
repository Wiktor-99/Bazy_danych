drop synonym db_user1.tb_pokoje_1;
drop synonym db_user1.tb_rezerwacje_1;
drop synonym db_user1.tb_pokoje_2;
drop synonym db_user1.tb_rezerwacje_2;
drop view db_user1.pokoje;

create synonym db_user1.tb_pokoje_1
for db_user1.tb_pokoje@orclpdb;
create synonym db_user1.tb_rezerwacje_1
for db_user1.tb_rezerwacje@orclpdb;

create synonym db_user1.tb_pokoje_2
for db_user1.tb_pokoje@orcl;
create synonym db_user1.tb_rezerwacje_2
for db_user1.tb_rezerwacje@orcl;

create view db_user1.pokoje as
   select * from db_user1.tb_pokoje_2
   union all
   select * from db_user1.tb_pokoje_1;
