
/*
 1. vypsat jm�na u�ivatel�, jejich� po��ta�e maj� OS macOS (Object)
*/
select c.user_id.user_first_name as Jm�no, c.user_id.user_last_name as P��jmen�, c.computer_name as N�zev_po��ta�e, c.os_id.os_name as N�zev_OS  from obj_a_computer c where c.os_id.os_name='MacOS';


/*
 2. 10 naposledy upraven�ch po��ta�� (object)
*/
select * from (select c.computer_name as N�zev_po��ta�e, c.computer_brand_id.computer_brand_maker as V�robce, c.computer_brand_id.compuer_model as Model, c.last_update_time as Datum_posledn�_zm�ny from obj_a_computer c order by c.last_update_time desc) where rownum < 11;


/*
 3. seznam ( jm�no, p��jmen�, role, e-mail, n�zev po��ta�e ) v�ech u�ivatel� kte�� pou��vaj� dan� po��ta� (computer_id) (object)
*/
select c.user_id.user_first_name as Jmeno, c.user_id.user_last_name as Prijmeni, c.user_id.user_role as Role, c.user_id.user_email_address as Email, c.computer_name as Nazev from obj_a_computer c where c.computer_id=1;


/*
 4. vypsat v�echny parametry po��ta�e, jeho n�zev, jm�no u�ivatele, n�zev OS, n�zev v�robce a modelu, kter� je st�le v z�ruce 2 let (object)
*/
select * from (select c.computer_parameters_id.extername_gpu as GPU, c.computer_parameters_id.optical_disk_drive as OpticalDiskDrive,c.computer_parameters_id.hdd as HDD,c.computer_parameters_id.processor as Processor,
c.computer_parameters_id.ram as RAM,c.computer_name as Nazev, c.last_update_time as UpdateTime, c.user_id.user_first_name as Jmeno, c.user_id.user_last_name as Prijmeni, c.os_id.os_name as OS, 
c.computer_brand_id.computer_brand_maker as Vyrobce, c.computer_brand_id.compuer_model as Model
from obj_a_computer c  
order by c.computer_name desc) where trunc(SYSDATE - 730) < last_update_time;


/*
 5. Vypsani v�ech po��ta�� a se�azen� podle po�tu u�ivatel� (object)
*/
select c.user_id.user_first_name as Jm�no, c.user_id.user_last_name as P��jmen�, count(c.computer_id) as Po�et_po��ta�� from obj_a_computer c
group by c.user_id.user_first_name, c.user_id.user_last_name order by Po�et_po��ta�� desc;
