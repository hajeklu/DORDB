--Atribut computer_name musí být unikátní (v továrnì se nesmìní nacházet dva poèítaèe se stejným jménem).
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT UQ_computer_name UNIQUE (computer_name);

--Atribut mac_address musí být unikátní.
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT UQ_mac_address UNIQUE (mac_address);

--Atribut inventory_number musí být unikátní.
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT UQ_inventory_number UNIQUE (inventory_number);

--Atribut discarded_time musí být vìtší jak atribut create_time (poèítaè nemùže být vyøazen døive než byl vytvoøen).
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT check_discarded_time CHECK (discarded_time > create_time);

--Atribut last_update_time musí být vìtší jak atribut create_time (poèítaè nemùže být editován døive než byl vytvoøen).
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT check_last_update_time CHECK (last_update_time > create_time);

--Atribut guarantees musí být vìtší jak atribut create_time.
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT check_guarantees CHECK (guarantees > create_time);

--Atribut mac_address nesmí být null.
ALTER TABLE A_COMPUTER
	MODIFY mac_address VARCHAR2(255) NOT NULL;

--Atribut computer_name nesmí být null. 
ALTER TABLE A_COMPUTER
	MODIFY computer_name VARCHAR2(255) NOT NULL;
  
--Atribut user_login musí být unikátní.
ALTER TABLE A_USER
	ADD CONSTRAINT UQ_user_login UNIQUE (user_login);

--Atribut user_email_address musí být unikátní.
ALTER TABLE A_USER
	ADD CONSTRAINT UQ_user_email_address UNIQUE (user_email_address);

--Atribut user_email_address musí obsahovat posobì jdoucí znaky "@" a ".". Dále nesmí zaèínat ani na znak "@" ani obsahovat dva tyto znaky v jedné adrese.
ALTER TABLE A_USER
	ADD CONSTRAINT check_user_email_address CHECK (user_email_address LIKE '%@%.%' AND user_email_address NOT LIKE '@%' AND user_email_address NOT LIKE '%@%@%');

--Atribut user_first_name nesmí být null.
ALTER TABLE A_USER
	MODIFY user_first_name VARCHAR2(255) NOT NULL;

--Atribut user_last_name nesmí být null.
ALTER TABLE A_USER
	MODIFY user_last_name VARCHAR2(255) NOT NULL;
    
--Atribut user_login nesmí být null.
ALTER TABLE A_USER
	MODIFY user_login VARCHAR2(255) NOT NULL;

--Atribut user_login nesmí být null.   
ALTER TABLE A_USER
	MODIFY user_password VARCHAR2(255) NOT NULL;

--Atribut hdd musí být vìtší jak 0.
ALTER TABLE A_COMPUTER_PARAMETERS
	ADD CONSTRAINT check_hdd CHECK (hdd > 0);

--Atribut ram musí být vìtší jak 0.
ALTER TABLE A_COMPUTER_PARAMETERS
	ADD CONSTRAINT check_ram CHECK (ram > 0);

--Atribut extername_GPU nesmí být null. 
ALTER TABLE A_COMPUTER_PARAMETERS
	MODIFY extername_GPU NUMBER(1,0) NOT NULL;

--Atribut optical_disk_drive nesmí být null.
ALTER TABLE A_COMPUTER_PARAMETERS
	MODIFY optical_disk_drive NUMBER(1,0) NOT NULL;

--Atribut processor nesmí být null.
ALTER TABLE A_COMPUTER_PARAMETERS
	MODIFY processor VARCHAR2(50) NOT NULL;

--Atribut os_version musí být vìtší jak 0.
ALTER TABLE A_OS
	ADD CONSTRAINT check_os_version CHECK (os_version > 0);

--Atribut os_name nesmí být null.
ALTER TABLE A_OS
	MODIFY os_name VARCHAR2(255) NOT NULL;


/*
B) Netriviální integritní omezení
Tabulka A_Computer
Jsou-li v tabulce A_Computer_brand vyplnìny atributy computer_brand_maker a computer_model pro daný poèítaè, pak musí být v tabulce A_Computer vyplnìn i atribut serial_number
*/