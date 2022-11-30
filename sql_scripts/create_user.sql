drop user db_user1;

create user db_user1 identified by db_user123;

grant connect to db_user1;
grant create session to db_user1;
grant create table to db_user1;
grant create procedure to db_user1;
grant create materialized view to db_user1;
grant create view to db_user1;
grant unlimited tablespace to db_user1;
grant create database link to db_user1;
grant create synonym to db_user1;