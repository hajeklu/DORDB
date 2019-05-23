spool '14_vysledky_dotazu.txt';
set autotrace on;

/*
 1. vypsat jména uživatelù, jejichž poèítaèe mají OS macOS (Object)
*/
select c.user_id.user_first_name as Jméno, c.user_id.user_last_name as Pøíjmení, c.computer_name as Název_poèítaèe, c.os_id.os_name as Název_OS  from obj_a_computer c where c.os_id.os_name='MacOS';


/*
 2. 10 naposledy upravených poèítaèù (object)
*/
select * from (select c.computer_name as Název_poèítaèe, c.computer_brand_id.computer_brand_maker as Výrobce, c.computer_brand_id.compuer_model as Model, c.last_update_time as Datum_poslední_zmìny from obj_a_computer c order by c.last_update_time desc) where rownum < 11;


/*
 3. seznam ( jméno, pøíjmení, role, e-mail, název poèítaèe ) všech uživatelù kteøí používají daný poèítaè (computer_id) (object)
*/
select c.user_id.user_first_name as Jmeno, c.user_id.user_last_name as Prijmeni, c.user_id.user_role as Role, c.user_id.user_email_address as Email, c.computer_name as Nazev from obj_a_computer c where c.computer_id=1;


/*
 4. vypsat všechny parametry poèítaèe, jeho název, jméno uživatele, název OS, název výrobce a modelu, který je stále v záruce 2 let (object)
*/
select c.computer_parameters_id.extername_gpu as GPU, c.computer_parameters_id.optical_disk_drive as OpticalDiskDrive,c.computer_parameters_id.hdd as HDD,c.computer_parameters_id.processor as Processor,
c.computer_parameters_id.ram as RAM,c.computer_name as Nazev, c.last_update_time as UpdateTime, c.user_id.user_first_name as Jmeno, c.user_id.user_last_name as Prijmeni, c.os_id.os_name as OS, 
c.computer_brand_id.computer_brand_maker as Vyrobce, c.computer_brand_id.compuer_model as Model
from obj_a_computer c  where SYSDATE < c.guarantees
order by c.computer_name desc;


/*
 5. Vypsani všech poèítaèù a seøazení podle poètu uživatelù - prvnich 20 (object)
*/
SELECT * FROM (select c.user_id.user_first_name as Jméno, c.user_id.user_last_name as Pøíjmení, count(c.computer_id) as Poèet_poèítaèù from obj_a_computer c
group by c.user_id.user_first_name, c.user_id.user_last_name order by Poèet_poèítaèù desc)where rownum < 21;

set autotrace off;
spool off;