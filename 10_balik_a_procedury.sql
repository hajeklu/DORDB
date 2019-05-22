CREATE OR REPLACE PACKAGE pocitacova_databaze_api AS
   PROCEDURE new_user (firstname IN VARCHAR2, lastname IN VARCHAR2, userrole IN VARCHAR2, userpassword IN VARCHAR2, login IN VARCHAR2, email IN VARCHAR2);
   PROCEDURE new_computer_brand (computer_brand_maker IN VARCHAR2, compuer_model IN VARCHAR2);
   PROCEDURE new_computer_parameters (extername_gpu IN NUMBER, optical_disk_drive IN NUMBER, hdd IN NUMBER, processor IN VARCHAR2, ram IN NUMBER);
   PROCEDURE new_os (os_name IN VARCHAR2, os_version IN NUMBER);
   PROCEDURE new_computer (bpcs_sessions IN VARCHAR2, comments IN VARCHAR2, create_time IN DATE, guarantees IN DATE, inventory_number IN NUMBER, last_update_time IN DATE, mac_address IN VARCHAR2, computer_name IN VARCHAR2, serial_number IN VARCHAR2,
  computer_brand_maker IN VARCHAR2, compuer_model IN VARCHAR2,
  extername_gpu IN NUMBER, optical_disk_drive IN NUMBER, hdd IN NUMBER, processor IN VARCHAR2, ram IN NUMBER,
  os_name IN VARCHAR2, os_version IN NUMBER,
  firstname IN VARCHAR2, lastname IN VARCHAR2, userrole IN VARCHAR2, userpassword IN VARCHAR2, login IN VARCHAR2, email IN VARCHAR2);
END pocitacova_databaze_api;
/

CREATE OR REPLACE PACKAGE BODY pocitacova_databaze_api AS
  PROCEDURE new_user (firstname IN VARCHAR2, lastname IN VARCHAR2, userrole IN VARCHAR2, userpassword IN VARCHAR2, login IN VARCHAR2, email IN VARCHAR2) AS
    BEGIN
    if(trim(firstname) is not null and trim(lastname) is not null and trim(firstname) is not null and trim(login) is not null and trim(userpassword) is not null and trim(userrole) is not null and trim(email) is not null) then
      INSERT INTO A_USER VALUES (seq_User.nextval, firstname, lastname, userrole, userpassword, login, email);
    else
      RAISE_APPLICATION_ERROR(-20000, 'Vyplnte vsechny udaje.');
    end if;
  END new_user;
  
  
  PROCEDURE new_computer_brand (computer_brand_maker IN VARCHAR2, compuer_model IN VARCHAR2) AS
    BEGIN
    if(trim(computer_brand_maker) is not null and trim(compuer_model) is not null) then
      INSERT INTO A_COMPUTER_BRAND VALUES (seq_Brand.nextval, computer_brand_maker, compuer_model);
    else
      RAISE_APPLICATION_ERROR(-20000, 'Chybne udaje vyrobce pocitace.');
    end if;
  END new_computer_brand;
  
  
  PROCEDURE new_computer_parameters (extername_gpu IN NUMBER, optical_disk_drive IN NUMBER, hdd IN NUMBER, processor IN VARCHAR2, ram IN NUMBER) AS
    BEGIN
    if(extername_gpu is not null and optical_disk_drive is not null and hdd>0 and trim(processor) is not null and ram>0) then
      INSERT INTO A_COMPUTER_PARAMETERS VALUES (seq_Parameters.nextval, extername_gpu, optical_disk_drive, hdd, processor, ram);
    else
      RAISE_APPLICATION_ERROR(-20000, 'Chybne udaje parametru pocitace.');
    end if;
  END new_computer_parameters;
  
  
  PROCEDURE new_os (os_name IN VARCHAR2, os_version IN NUMBER) AS
    BEGIN
    if(trim(os_name) is not null and os_version>0) then
      INSERT INTO A_OS VALUES (seq_OS.nextval, os_name, os_version);
    else
      RAISE_APPLICATION_ERROR(-20000, 'Chybne udaje OS pocitace.');
    end if;
  END new_os;
  
  
  
  PROCEDURE new_computer (
  bpcs_sessions IN VARCHAR2, comments IN VARCHAR2, create_time IN DATE, guarantees IN DATE, inventory_number IN NUMBER, last_update_time IN DATE, mac_address IN VARCHAR2, computer_name IN VARCHAR2, serial_number IN VARCHAR2,
  computer_brand_maker IN VARCHAR2, compuer_model IN VARCHAR2,
  extername_gpu IN NUMBER, optical_disk_drive IN NUMBER, hdd IN NUMBER, processor IN VARCHAR2, ram IN NUMBER,
  os_name IN VARCHAR2, os_version IN NUMBER,
  firstname IN VARCHAR2, lastname IN VARCHAR2, userrole IN VARCHAR2, userpassword IN VARCHAR2, login IN VARCHAR2, email IN VARCHAR2) AS    
  
  glob_maker NUMBER;
  glob_parameters NUMBER;
  glob_os NUMBER;
  glob_user NUMBER;
  glob_seq NUMBER;

    BEGIN  
    
      BEGIN
      select a_computer_brand.computer_brand_id into glob_maker from a_computer_brand where computer_brand_maker = a_computer_brand.computer_brand_maker and compuer_model=a_computer_brand.compuer_model;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            new_computer_brand(computer_brand_maker, compuer_model);
            SELECT last_number into glob_maker FROM user_sequences WHERE sequence_name = 'seq_Brand';
      END;
      
      BEGIN
      select a_computer_parameters.computer_parameters_id into glob_parameters from a_computer_parameters where extername_gpu = a_computer_parameters.extername_gpu 
      and optical_disk_drive=a_computer_parameters.optical_disk_drive and hdd=a_computer_parameters.hdd and processor=a_computer_parameters.processor and ram=a_computer_parameters.ram;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            new_computer_parameters(extername_gpu, optical_disk_drive, hdd, processor, ram);
            SELECT last_number into glob_parameters FROM user_sequences WHERE sequence_name = 'seq_Parameters';
      END;
      
      BEGIN
      select a_os.os_id into glob_os from a_os where os_name = a_os.os_name and os_version=a_os.os_version;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            new_os(os_name, os_version);
            SELECT last_number into glob_os FROM user_sequences WHERE sequence_name = 'seq_OS';
      END;
      
      BEGIN
      select a_user.user_id into glob_user from a_user where firstname = a_user.user_first_name and lastname=a_user.user_last_name and userrole=a_user.user_role and userpassword=a_user.user_password
      and login=a_user.user_login and email=a_user.user_email_address;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            new_user(firstname, lastname, userrole, userpassword, login, email);
            SELECT last_number into glob_user FROM user_sequences WHERE sequence_name = 'seq_User';
      END;
      
      BEGIN
       SELECT seq_Computer.nextval into glob_seq FROM dual;
      END;
      
      INSERT INTO A_COMPUTER VALUES (glob_seq, bpcs_sessions, comments, create_time, null, guarantees, inventory_number, last_update_time, mac_address, computer_name, 
      serial_number, glob_maker, glob_parameters, glob_os, glob_user);
      
  END new_computer;  
  
END pocitacova_databaze_api;
/