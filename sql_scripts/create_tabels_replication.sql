create materialized view db_user1.tb_hotele
  build immediate 
  refresh fast
  next sysdate+(1/(24*60*6))
  with primary key
as 
select * from db_user1.tb_hotele@orcl1;

create materialized view db_user1.tb_wyzywienie
  build immediate 
  refresh on commit
  with primary key
as 
select * from db_user1.tb_wyzywienie@orcl1;
