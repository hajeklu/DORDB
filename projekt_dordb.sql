/*
DROP TABLE A_COMPUTER;
DROP TABLE A_COMPUTER_BRAND;
DROP TABLE A_USER;
DROP TABLE A_COMPUTER_PARAMETERS;
DROP TABLE A_OS;
*/


/*
--------------TABLE----------------
*/

CREATE TABLE A_COMPUTER
( 
   computer_id NUMBER,
   bpcs_seassions VARCHAR2(255),
   comments VARCHAR2(255),
   create_time DATE,
   discarded_time DATE,
   guarantees DATE,
   inventory_number VARCHAR2(255),
   last_update_time DATE,
   mac_address VARCHAR2(255),
   computer_name VARCHAR2(255),
   serial_number VARCHAR2(255),
   computer_brand_id NUMBER,
   computer_parameters_id NUMBER,
   os_id NUMBER,
   user_id NUMBER,
   
   CONSTRAINT computer_id PRIMARY KEY (computer_id)
);

CREATE TABLE A_COMPUTER_BRAND
( 
    computer_brand_id NUMBER,
    computer_brand_maker VARCHAR2(255),
    compuer_model VARCHAR2(255),
    
    CONSTRAINT computer_brand_id PRIMARY KEY (computer_brand_id)
);

CREATE TABLE A_USER
(
    user_id NUMBER,
    user_first_name VARCHAR2(255),
    user_last_name VARCHAR2(255),
    user_role VARCHAR2(50),
    user_password VARCHAR2(255),
    user_login VARCHAR2(255),
    mail_address VARCHAR2(255),
    
    CONSTRAINT user_id PRIMARY KEY (user_id)    

);

CREATE TABLE A_COMPUTER_PARAMETERS
(
    computer_parameters_id NUMBER,
    extername_GPU NUMBER(1,0),
    optical_disk_drive NUMBER(1,0),
    hdd NUMBER,
    processor VARCHAR(255),
    ram NUMBER,
    
    CONSTRAINT computer_parameters_id PRIMARY KEY (computer_parameters_id) 
    
);

CREATE TABLE A_OS
(
    os_id NUMBER,
    os_name VARCHAR(255),
    os_version NUMBER,
    
    CONSTRAINT os_id PRIMARY KEY (os_id) 
    
);


/*
-----------FK----------------
*/
ALTER TABLE A_COMPUTER
ADD CONSTRAINT fk_computer_brand_id
  FOREIGN KEY (computer_brand_id)
  REFERENCES A_COMPUTER_BRAND(computer_brand_id);
  
 ALTER TABLE A_COMPUTER
ADD CONSTRAINT fk_computer_parameters_id
  FOREIGN KEY (computer_parameters_id)
  REFERENCES A_COMPUTER_PARAMETERS(computer_parameters_id);
  
  ALTER TABLE A_COMPUTER
ADD CONSTRAINT fk_os_id
  FOREIGN KEY (os_id)
  REFERENCES A_OS(os_id);
  
    ALTER TABLE A_COMPUTER
ADD CONSTRAINT fk_user_id
  FOREIGN KEY (user_id)
  REFERENCES A_USER(user_id);
  
   