drop synonym db_user1.tb_pokoje_1;
drop synonym db_user1.tb_rezerwacje_1;
drop synonym db_user1.tb_pokoje_2;
drop synonym db_user1.tb_rezerwacje_2;

create synonym db_user1.tb_pokoje_1
for db_user1.tb_pokoje@orclpdb;
create synonym db_user1.tb_rezerwacje_1
for db_user1.tb_rezerwacje@orclpdb;

create synonym db_user1.tb_pokoje_2
for db_user1.tb_pokoje@orcl;
create synonym db_user1.tb_rezerwacje_2
for db_user1.tb_rezerwacje@orcl;
