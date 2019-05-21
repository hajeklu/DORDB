
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT check_discarded_time CHECK (discarded_time > create_time);
    
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT check_last_update_time CHECK (last_update_time > create_time);
    
ALTER TABLE A_COMPUTER
	ADD CONSTRAINT check_guarantees CHECK (guarantees > create_time);
    
ALTER TABLE A_COMPUTER
	MODIFY mac_address VARCHAR2(255) NOT NULL;
    
ALTER TABLE A_COMPUTER
	MODIFY computer_name VARCHAR2(255) NOT NULL;
    
    
  
ALTER TABLE A_USER
	MODIFY user_first_name VARCHAR2(255) NOT NULL;
    
ALTER TABLE A_USER
	MODIFY user_last_name VARCHAR2(255) NOT NULL;
    
ALTER TABLE A_USER
	ADD CONSTRAINT check_user_email_address CHECK (user_email_address LIKE '%@%.%' AND user_email_address NOT LIKE '@%' AND user_email_address NOT LIKE '%@%@%');

ALTER TABLE A_USER
	MODIFY user_login VARCHAR2(255) NOT NULL;
    
ALTER TABLE A_USER
	MODIFY user_password VARCHAR2(255) NOT NULL;
    
ALTER TABLE A_USER
	MODIFY user_role VARCHAR2(50) NOT NULL;



ALTER TABLE A_COMPUTER_PARAMETERS
	ADD CONSTRAINT check_hdd CHECK (hdd > 0);
  
ALTER TABLE A_COMPUTER_PARAMETERS
	ADD CONSTRAINT check_ram CHECK (ram > 0);
    
ALTER TABLE A_COMPUTER_PARAMETERS
	MODIFY extername_GPU NUMBER(1,0) NOT NULL;
    
ALTER TABLE A_COMPUTER_PARAMETERS
	MODIFY optical_disk_drive NUMBER(1,0) NOT NULL;
    
ALTER TABLE A_COMPUTER_PARAMETERS
	MODIFY processor VARCHAR2(50) NOT NULL;



ALTER TABLE A_OS
	ADD CONSTRAINT check_os_version CHECK (os_version > 0);
    
ALTER TABLE A_OS
	MODIFY os_name VARCHAR2(255) NOT NULL;