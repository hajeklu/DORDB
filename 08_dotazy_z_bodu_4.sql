SET AUTOTRACE ON;

-- 1. vypsat jména uživatelù, jejichž poèítaèe mají OS macOS (JOIN)
select u.user_first_name as Jméno, u.user_last_name as Pøíjmení, c.computer_name as Název_poèítaèe, o.os_name as Název_OS from a_user u JOIN a_computer c on (u.user_id=c.user_id) join a_os o on (c.os_id=o.os_id) where o.os_name='macOS';

-- 1. vypsat jména uživatelù, jejichž poèítaèe mají OS macOS (Object)
select u.user_first_name as Jméno, u.user_last_name as Pøíjmení, c.computer_name as Název_poèítaèe, o.os_name as Název_OS  from obj_a_user u, obj_a_computer c, obj_a_os o where c.os.os_name='macOS';



-- 2. 10 naposledy upravených poèítaèù (JOIN)
select * from (select c.computer_name as Název_poèítaèe, b.computer_brand_maker as Výrobce, b.compuer_model as Model, c.last_update_time as Datum_poslední_zmìny from a_computer c join a_computer_brand b on (c.computer_brand_id=b.computer_brand_id) order by c.last_update_time desc) where rownum < 11;

-- 2. 10 naposledy upravených poèítaèù (object)
select * from (select c.computer_name as Název_poèítaèe, b.computer_brand_maker as Výrobce, b.compuer_model as Model, c.last_update_time as Datum_poslední_zmìny from obj_a_computer c, obj_a_computer_brand b order by c.last_update_time desc) where rownum < 11;



-- 3. seznam ( jméno, pøíjmení, role, e-mail, název poèítaèe ) všech uživatelù kteøí používají daný poèítaè (computer_id) (JOIN)
select u.user_first_name, u.user_last_name, u.user_role, u.user_email_address, c.computer_name from a_user u join a_computer c on u.user_id = c.user_id where c.computer_id=1;

-- 3. seznam ( jméno, pøíjmení, role, e-mail, název poèítaèe ) všech uživatelù kteøí používají daný poèítaè (computer_id) (object)
select u.user_first_name, u.user_last_name, u.user_role, u.user_email_address, c.computer_name from obj_a_user u, obj_a_computer c where c.computer_id=1;



-- 4. vypsat všechny parametry poèítaèe, jeho název, jméno uživatele, název OS, název výrobce a modelu, který je stále v záruce 2 let (JOIN)
select * from (select p.*, c.computer_name, c.last_update_time, u.user_first_name, u.user_last_name, o.os_name, b.computer_brand_maker, b.compuer_model
from a_computer_parameters p 
join a_computer c on (c.computer_parameters_id=p.computer_parameters_id) join a_computer_brand b on (c.computer_brand_id=b.computer_brand_id) join a_user u on (c.user_id=u.user_id) join a_os o on (c.os_id=o.os_id) 
order by c.computer_name desc) where trunc(SYSDATE - 730) < last_update_time;

-- 4. vypsat všechny parametry poèítaèe, jeho název, jméno uživatele, název OS, název výrobce a modelu, který je stále v záruce 2 let (object)
select * from (select p.*, c.computer_name, c.last_update_time, u.user_first_name, u.user_last_name, o.os_name, b.computer_brand_maker, b.compuer_model
from obj_a_computer_parameters p, obj_a_computer c, obj_a_computer_brand b, obj_a_user u, obj_a_os o  
order by c.computer_name desc) where trunc(SYSDATE - 730) < last_update_time;



-- 5. Vypsani všech uživatelù a seøazení podle poètu poèítaèù (JOIN)
select u.user_first_name as Jméno, u.user_last_name as Pøíjmení, count(c.computer_id) as Poèet_poèítaèù from a_user u join a_computer c on (c.user_id=u.user_id) 
group by u.user_first_name, u.user_last_name order by Poèet_poèítaèù desc;

-- 5. Vypsani všech poèítaèù a seøazení podle poètu uživatelù (object)
select u.user_first_name as Jméno, u.user_last_name as Pøíjmení, count(c.computer_id) as Poèet_poèítaèù from obj_a_user u, obj_a_computer c
group by u.user_first_name, u.user_last_name order by Poèet_poèítaèù desc;

SET AUTOTRACE OFF;