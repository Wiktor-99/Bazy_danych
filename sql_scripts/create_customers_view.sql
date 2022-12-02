drop view db_user1.tb_klienci;
drop synonym db_user1.tb_klienci_podstawowe;
drop synonym db_user1.tb_klienci_logowanie;

create synonym db_user1.tb_klienci_podstawowe
for db_user1.tb_klienci_dane_podstawowe@orclpdb;
create synonym db_user1.tb_klienci_logowanie
for db_user1.tb_klienci_dane_logowania@orcl;

create view db_user1.tb_klienci as 
select db_user1.tb_klienci_podstawowe.*, db_user1.tb_klienci_logowanie.haslo, db_user1.tb_klienci_logowanie.login
from db_user1.tb_klienci_logowanie FULL join db_user1.tb_klienci_podstawowe
on db_user1.tb_klienci_logowanie.id_klienta = db_user1.tb_klienci_logowanie.id_klienta;
