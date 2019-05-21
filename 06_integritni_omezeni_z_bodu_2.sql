    
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


--Pokud ma novy pocitac vyplneneho vyrobce a model (COMPUTER_BRAND), pak jeho SERIAL_NUMBER nesmi byt NULL
create or replace PROCEDURE kontrola_brand (computerid IN NUMBER) AS
glob_serial VARCHAR2(255);
glob_model VARCHAR2(255);
glob_brand_maker VARCHAR2(255);
BEGIN

  BEGIN
  select computer_brand_maker into glob_brand_maker from a_computer_brand join a_computer on (a_computer_brand.computer_brand_id=a_computer.computer_brand_id) where computerid = a_computer.computer_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        glob_brand_maker := NULL;
  END;
  
  BEGIN
  select compuer_model into glob_model from a_computer_brand join a_computer on (a_computer_brand.computer_brand_id=a_computer.computer_brand_id) where computerid = a_computer.computer_id;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        glob_model := NULL;
  END;

    IF(trim(glob_brand_maker) is not NULL OR trim(glob_model) is not NULL) THEN
      
      BEGIN
      select c.serial_number into glob_serial from a_computer_brand b join a_computer c on (b.computer_brand_id=c.computer_brand_id) where computerid = c.computer_id;
        EXCEPTION
      WHEN NO_DATA_FOUND THEN
          glob_serial := NULL;
      END;
      
      -- vyhození vyjimky
      IF(glob_serial is NULL) THEN
        RAISE_APPLICATION_ERROR(-20000, 'Pole serial_number musí být vyplnìno.');
      END IF;
    END IF;
END;

/
CREATE TRIGGER brand_com
BEFORE insert
ON A_COMPUTER
FOR EACH ROW
BEGIN
kontrola_brand(:NEW.COMPUTER_ID);
END;
/