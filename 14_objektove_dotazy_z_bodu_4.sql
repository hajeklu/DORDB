
/*
 1. vypsat jména uivatelù, jejich poèítaèe mají OS macOS (Object)
*/
select c.user_id.user_first_name as Jméno, c.user_id.user_last_name as Pøíjmení, c.computer_name as Název_poèítaèe, c.os_id.os_name as Název_OS  from obj_a_computer c where c.os_id.os_name='MacOS';


/*
 2. 10 naposledy upravenıch poèítaèù (object)
*/
select * from (select c.computer_name as Název_poèítaèe, c.computer_brand_id.computer_brand_maker as Vırobce, c.computer_brand_id.compuer_model as Model, c.last_update_time as Datum_poslední_zmìny from obj_a_computer c order by c.last_update_time desc) where rownum < 11;


/*
 3. seznam ( jméno, pøíjmení, role, e-mail, název poèítaèe ) všech uivatelù kteøí pouívají danı poèítaè (computer_id) (object)
*/
select c.user_id.user_first_name as Jmeno, c.user_id.user_last_name as Prijmeni, c.user_id.user_role as Role, c.user_id.user_email_address as Email, c.computer_name as Nazev from obj_a_computer c where c.computer_id=1;


/*
 4. vypsat všechny parametry poèítaèe, jeho název, jméno uivatele, název OS, název vırobce a modelu, kterı je stále v záruce 2 let (object)
*/
select * from (select c.computer_parameters_id.extername_gpu as GPU, c.computer_parameters_id.optical_disk_drive as OpticalDiskDrive,c.computer_parameters_id.hdd as HDD,c.computer_parameters_id.processor as Processor,
c.computer_parameters_id.ram as RAM,c.computer_name as Nazev, c.last_update_time as UpdateTime, c.user_id.user_first_name as Jmeno, c.user_id.user_last_name as Prijmeni, c.os_id.os_name as OS, 
c.computer_brand_id.computer_brand_maker as Vyrobce, c.computer_brand_id.compuer_model as Model
from obj_a_computer c  
order by c.computer_name desc) where trunc(SYSDATE - 730) < last_update_time;


/*
 5. Vypsani všech poèítaèù a seøazení podle poètu uivatelù (object)
*/
select c.user_id.user_first_name as Jméno, c.user_id.user_last_name as Pøíjmení, count(c.computer_id) as Poèet_poèítaèù from obj_a_computer c
group by c.user_id.user_first_name, c.user_id.user_last_name order by Poèet_poèítaèù desc;
