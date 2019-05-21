SET AUTOTRACE ON;
spool '08_vysledky_dotazu6.txt';

/*
 1. vypsat jm�na u�ivatel�, jejich� po��ta�e maj� OS macOS (JOIN)
*/
select u.user_first_name as Jm�no, u.user_last_name as P��jmen�, c.computer_name as N�zev_po��ta�e, o.os_name as N�zev_OS from a_user u JOIN a_computer c on (u.user_id=c.user_id) join a_os o on (c.os_id=o.os_id) where o.os_name='MacOS';


/*
 2. 10 naposledy upraven�ch po��ta�� (JOIN)
*/
--A
select * from (select c.computer_name as N�zev_po��ta�e, b.computer_brand_maker as V�robce, b.compuer_model as Model, c.last_update_time as Datum_posledn�_zm�ny 
from a_computer c join a_computer_brand b on (c.computer_brand_id=b.computer_brand_id) order by c.last_update_time desc) where rownum < 11;
--B
select * from (select c.computer_name as N�zev_po��ta�e, (SELECT b.computer_brand_maker from a_computer_brand b where c.computer_brand_id=b.computer_brand_id) as Vyrobce, 
(SELECT  b.compuer_model from a_computer_brand b where c.computer_brand_id=b.computer_brand_id) as PCModel, c.last_update_time as Datum_posledn�_zm�ny 
from a_computer c order by c.last_update_time desc) where rownum < 11;


/*
 3. seznam ( jm�no, p��jmen�, role, e-mail, n�zev po��ta�e ) v�ech u�ivatel� kte�� pou��vaj� dan� po��ta� (computer_id) (JOIN)
*/
select u.user_first_name as Jmeno, u.user_last_name as Prijmeni, u.user_role as Role, u.user_email_address as Email, c.computer_name as Nazev from a_user u join a_computer c on u.user_id = c.user_id where c.computer_id=1;


/*
 4. vypsat v�echny parametry po��ta�e, jeho n�zev, jm�no u�ivatele, n�zev OS, n�zev v�robce a modelu, kter� je st�le v z�ruce (JOIN)
*/
select p.extername_gpu as GPU, p.optical_disk_drive as OpticalDiskDrive, p.hdd as HDD, p.processor as Processor, p.ram as RAM, c.computer_name as Nazev, c.guarantees as Guarantees,
u.user_first_name as Jmeno, u.user_last_name as Prijmeni, o.os_name as OS, b.computer_brand_maker as Vyrobce, b.compuer_model as PCModel
from a_computer_parameters p 
join a_computer c on (c.computer_parameters_id=p.computer_parameters_id) join a_computer_brand b on (c.computer_brand_id=b.computer_brand_id) join a_user u on (c.user_id=u.user_id) join a_os o on (c.os_id=o.os_id) 
where SYSDATE < c.guarantees ;



/*
 5. Vypsani u�ivatel� a se�azen� podle po�tu po��ta�� - prvn�ch 20 (JOIN)
*/
--A
select * from (select u.user_first_name as Jm�no, u.user_last_name as P��jmen�, count(c.computer_id) as Po�et_po��ta�� from a_user u left outer join a_computer c on (c.user_id=u.user_id) 
group by u.user_first_name, u.user_last_name order by Po�et_po��ta�� desc) where rownum < 21;
--B
select * from (select u.user_first_name as Jm�no, u.user_last_name as P��jmen�, (SELECT count(m.computer_id) FROM a_computer m where m.user_id=u.user_id) as Po�et_po��ta�� from a_user u 
order by Po�et_po��ta�� desc) where rownum < 21;

SET AUTOTRACE OFF;
spool off;