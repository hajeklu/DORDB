SET AUTOTRACE ON;

-- 1. vypsat jm�na u�ivatel�, jejich� po��ta�e maj� OS macOS (JOIN)
select u.user_first_name as Jm�no, u.user_last_name as P��jmen�, c.computer_name as N�zev_po��ta�e, o.os_name as N�zev_OS from a_user u JOIN a_computer c on (u.user_id=c.user_id) join a_os o on (c.os_id=o.os_id) where o.os_name='macOS';

-- 1. vypsat jm�na u�ivatel�, jejich� po��ta�e maj� OS macOS (Object)
select u.user_first_name as Jm�no, u.user_last_name as P��jmen�, c.computer_name as N�zev_po��ta�e, o.os_name as N�zev_OS  from obj_a_user u, obj_a_computer c, obj_a_os o where c.os.os_name='macOS';



-- 2. 10 naposledy upraven�ch po��ta�� (JOIN)
select * from (select c.computer_name as N�zev_po��ta�e, b.computer_brand_maker as V�robce, b.compuer_model as Model, c.last_update_time as Datum_posledn�_zm�ny from a_computer c join a_computer_brand b on (c.computer_brand_id=b.computer_brand_id) order by c.last_update_time desc) where rownum < 11;

-- 2. 10 naposledy upraven�ch po��ta�� (object)
select * from (select c.computer_name as N�zev_po��ta�e, b.computer_brand_maker as V�robce, b.compuer_model as Model, c.last_update_time as Datum_posledn�_zm�ny from obj_a_computer c, obj_a_computer_brand b order by c.last_update_time desc) where rownum < 11;



-- 3. seznam ( jm�no, p��jmen�, role, e-mail, n�zev po��ta�e ) v�ech u�ivatel� kte�� pou��vaj� dan� po��ta� (computer_id) (JOIN)
select u.user_first_name, u.user_last_name, u.user_role, u.user_email_address, c.computer_name from a_user u join a_computer c on u.user_id = c.user_id where c.computer_id=1;

-- 3. seznam ( jm�no, p��jmen�, role, e-mail, n�zev po��ta�e ) v�ech u�ivatel� kte�� pou��vaj� dan� po��ta� (computer_id) (object)
select u.user_first_name, u.user_last_name, u.user_role, u.user_email_address, c.computer_name from obj_a_user u, obj_a_computer c where c.computer_id=1;



-- 4. vypsat v�echny parametry po��ta�e, jeho n�zev, jm�no u�ivatele, n�zev OS, n�zev v�robce a modelu, kter� je st�le v z�ruce 2 let (JOIN)
select * from (select p.*, c.computer_name, c.last_update_time, u.user_first_name, u.user_last_name, o.os_name, b.computer_brand_maker, b.compuer_model
from a_computer_parameters p 
join a_computer c on (c.computer_parameters_id=p.computer_parameters_id) join a_computer_brand b on (c.computer_brand_id=b.computer_brand_id) join a_user u on (c.user_id=u.user_id) join a_os o on (c.os_id=o.os_id) 
order by c.computer_name desc) where trunc(SYSDATE - 730) < last_update_time;

-- 4. vypsat v�echny parametry po��ta�e, jeho n�zev, jm�no u�ivatele, n�zev OS, n�zev v�robce a modelu, kter� je st�le v z�ruce 2 let (object)
select * from (select p.*, c.computer_name, c.last_update_time, u.user_first_name, u.user_last_name, o.os_name, b.computer_brand_maker, b.compuer_model
from obj_a_computer_parameters p, obj_a_computer c, obj_a_computer_brand b, obj_a_user u, obj_a_os o  
order by c.computer_name desc) where trunc(SYSDATE - 730) < last_update_time;



-- 5. Vypsani v�ech u�ivatel� a se�azen� podle po�tu po��ta�� (JOIN)
select u.user_first_name as Jm�no, u.user_last_name as P��jmen�, count(c.computer_id) as Po�et_po��ta�� from a_user u join a_computer c on (c.user_id=u.user_id) 
group by u.user_first_name, u.user_last_name order by Po�et_po��ta�� desc;

-- 5. Vypsani v�ech po��ta�� a se�azen� podle po�tu u�ivatel� (object)
select u.user_first_name as Jm�no, u.user_last_name as P��jmen�, count(c.computer_id) as Po�et_po��ta�� from obj_a_user u, obj_a_computer c
group by u.user_first_name, u.user_last_name order by Po�et_po��ta�� desc;

SET AUTOTRACE OFF;