--Atribut computer_name mus� b�t unik�tn� (v tov�rn� se nesm�n� nach�zet dva po��ta�e se stejn�m jm�nem).
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT UQ_computer_name UNIQUE (computer_name);

--Atribut mac_address mus� b�t unik�tn�.
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT UQ_mac_address UNIQUE (mac_address);

--Atribut inventory_number mus� b�t unik�tn�.
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT UQ_inventory_number UNIQUE (inventory_number);

--Atribut discarded_time mus� b�t v�t�� jak atribut create_time (po��ta� nem��e b�t vy�azen d�ive ne� byl vytvo�en).
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT check_discarded_time CHECK (discarded_time > create_time);

--Atribut last_update_time mus� b�t v�t�� jak atribut create_time (po��ta� nem��e b�t editov�n d�ive ne� byl vytvo�en).
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT check_last_update_time CHECK (last_update_time > create_time);

--Atribut guarantees mus� b�t v�t�� jak atribut create_time.
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT check_guarantees CHECK (guarantees > create_time);

--Atribut mac_address nesm� b�t null.
ALTER TABLE A_COMPUTER
	MODIFY mac_address VARCHAR2(255) NOT NULL;

--Atribut computer_name nesm� b�t null. 
ALTER TABLE A_COMPUTER
	MODIFY computer_name VARCHAR2(255) NOT NULL;
  
--Atribut user_login mus� b�t unik�tn�.
ALTER TABLE A_USER
	ADD CONSTRAINT UQ_user_login UNIQUE (user_login);

--Atribut user_email_address mus� b�t unik�tn�.
ALTER TABLE A_USER
	ADD CONSTRAINT UQ_user_email_address UNIQUE (user_email_address);

--Atribut user_email_address mus� obsahovat posob� jdouc� znaky "@" a ".". D�le nesm� za��nat ani na znak "@" ani obsahovat dva tyto znaky v jedn� adrese.
ALTER TABLE A_USER
	ADD CONSTRAINT check_user_email_address CHECK (user_email_address LIKE '%@%.%' AND user_email_address NOT LIKE '@%' AND user_email_address NOT LIKE '%@%@%');

--Atribut user_first_name nesm� b�t null.
ALTER TABLE A_USER
	MODIFY user_first_name VARCHAR2(255) NOT NULL;

--Atribut user_last_name nesm� b�t null.
ALTER TABLE A_USER
	MODIFY user_last_name VARCHAR2(255) NOT NULL;
    
--Atribut user_login nesm� b�t null.
ALTER TABLE A_USER
	MODIFY user_login VARCHAR2(255) NOT NULL;

--Atribut user_login nesm� b�t null.   
ALTER TABLE A_USER
	MODIFY user_password VARCHAR2(255) NOT NULL;

--Atribut hdd mus� b�t v�t�� jak 0.
ALTER TABLE A_COMPUTER_PARAMETERS
	ADD CONSTRAINT check_hdd CHECK (hdd > 0);

--Atribut ram mus� b�t v�t�� jak 0.
ALTER TABLE A_COMPUTER_PARAMETERS
	ADD CONSTRAINT check_ram CHECK (ram > 0);

--Atribut extername_GPU nesm� b�t null. 
ALTER TABLE A_COMPUTER_PARAMETERS
	MODIFY extername_GPU NUMBER(1,0) NOT NULL;

--Atribut optical_disk_drive nesm� b�t null.
ALTER TABLE A_COMPUTER_PARAMETERS
	MODIFY optical_disk_drive NUMBER(1,0) NOT NULL;

--Atribut processor nesm� b�t null.
ALTER TABLE A_COMPUTER_PARAMETERS
	MODIFY processor VARCHAR2(50) NOT NULL;

--Atribut os_version mus� b�t v�t�� jak 0.
ALTER TABLE A_OS
	ADD CONSTRAINT check_os_version CHECK (os_version > 0);

--Atribut os_name nesm� b�t null.
ALTER TABLE A_OS
	MODIFY os_name VARCHAR2(255) NOT NULL;


/*
B) Netrivi�ln� integritn� omezen�
Tabulka A_Computer
Jsou-li v tabulce A_Computer_brand vypln�ny atributy computer_brand_maker a computer_model pro dan� po��ta�, pak mus� b�t v tabulce A_Computer vypln�n i atribut serial_number
*/