SET AUTOTRACE ON;
spool '08_vysledky_dotazu6.txt';

/*
 1. vypsat jména uživatelù, jejichž poèítaèe mají OS macOS (JOIN)
*/
select u.user_first_name as Jméno, u.user_last_name as Pøíjmení, c.computer_name as Název_poèítaèe, o.os_name as Název_OS from a_user u JOIN a_computer c on (u.user_id=c.user_id) join a_os o on (c.os_id=o.os_id) where o.os_name='MacOS';


/*
 2. 10 naposledy upravených poèítaèù (JOIN)
*/
--A
select * from (select c.computer_name as Název_poèítaèe, b.computer_brand_maker as Výrobce, b.compuer_model as Model, c.last_update_time as Datum_poslední_zmìny 
from a_computer c join a_computer_brand b on (c.computer_brand_id=b.computer_brand_id) order by c.last_update_time desc) where rownum < 11;
--B
select * from (select c.computer_name as Název_poèítaèe, (SELECT b.computer_brand_maker from a_computer_brand b where c.computer_brand_id=b.computer_brand_id) as Vyrobce, 
(SELECT  b.compuer_model from a_computer_brand b where c.computer_brand_id=b.computer_brand_id) as PCModel, c.last_update_time as Datum_poslední_zmìny 
from a_computer c order by c.last_update_time desc) where rownum < 11;


/*
 3. seznam ( jméno, pøíjmení, role, e-mail, název poèítaèe ) všech uživatelù kteøí používají daný poèítaè (computer_id) (JOIN)
*/
select u.user_first_name as Jmeno, u.user_last_name as Prijmeni, u.user_role as Role, u.user_email_address as Email, c.computer_name as Nazev from a_user u join a_computer c on u.user_id = c.user_id where c.computer_id=1;


/*
 4. vypsat všechny parametry poèítaèe, jeho název, jméno uživatele, název OS, název výrobce a modelu, který je stále v záruce (JOIN)
*/
select p.extername_gpu as GPU, p.optical_disk_drive as OpticalDiskDrive, p.hdd as HDD, p.processor as Processor, p.ram as RAM, c.computer_name as Nazev, c.guarantees as Guarantees,
u.user_first_name as Jmeno, u.user_last_name as Prijmeni, o.os_name as OS, b.computer_brand_maker as Vyrobce, b.compuer_model as PCModel
from a_computer_parameters p 
join a_computer c on (c.computer_parameters_id=p.computer_parameters_id) join a_computer_brand b on (c.computer_brand_id=b.computer_brand_id) join a_user u on (c.user_id=u.user_id) join a_os o on (c.os_id=o.os_id) 
where SYSDATE < c.guarantees ;



/*
 5. Vypsani uživatelù a seøazení podle poètu poèítaèù - prvních 20 (JOIN)
*/
--A
select * from (select u.user_first_name as Jméno, u.user_last_name as Pøíjmení, count(c.computer_id) as Poèet_poèítaèù from a_user u left outer join a_computer c on (c.user_id=u.user_id) 
group by u.user_first_name, u.user_last_name order by Poèet_poèítaèù desc) where rownum < 21;
--B
select * from (select u.user_first_name as Jméno, u.user_last_name as Pøíjmení, (SELECT count(m.computer_id) FROM a_computer m where m.user_id=u.user_id) as Poèet_poèítaèù from a_user u 
order by Poèet_poèítaèù desc) where rownum < 21;

SET AUTOTRACE OFF;
spool off;