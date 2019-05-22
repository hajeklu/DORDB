create or replace PACKAGE pocitacova_databaze_api AS
   PROCEDURE new_user (Ifirstname IN VARCHAR2, Ilastname IN VARCHAR2, Iuserrole IN VARCHAR2, Iuserpassword IN VARCHAR2, Ilogin IN VARCHAR2, Iemail IN VARCHAR2);
   PROCEDURE new_computer_brand (Icomputer_brand_maker IN VARCHAR2, Icompuer_model IN VARCHAR2);
   PROCEDURE new_computer_parameters (Iextername_gpu IN NUMBER, Ioptical_disk_drive IN NUMBER, Ihdd IN NUMBER, Iprocessor IN VARCHAR2, Iram IN NUMBER);
   PROCEDURE new_os (Ios_name IN VARCHAR2, Ios_version IN NUMBER);
   PROCEDURE new_computer (Ibpcs_sessions IN VARCHAR2, Icomments IN VARCHAR2, Icreate_time IN DATE, Iguarantees IN DATE, Iinventory_number IN VARCHAR2, Ilast_update_time IN DATE, Imac_address IN VARCHAR2, Icomputer_name IN VARCHAR2, Iserial_number IN VARCHAR2,
  Icomputer_brand_maker IN VARCHAR2, Icompuer_model IN VARCHAR2,
  Iextername_gpu IN NUMBER, Ioptical_disk_drive IN NUMBER, Ihdd IN NUMBER, Iprocessor IN VARCHAR2, Iram IN NUMBER,
  Ios_name IN VARCHAR2, Ios_version IN NUMBER,
  Ifirstname IN VARCHAR2, Ilastname IN VARCHAR2, Iuserrole IN VARCHAR2, Iuserpassword IN VARCHAR2, Ilogin IN VARCHAR2, Iemail IN VARCHAR2);
END pocitacova_databaze_api;
/

create or replace PACKAGE BODY pocitacova_databaze_api AS
  PROCEDURE new_user (Ifirstname IN VARCHAR2, Ilastname IN VARCHAR2, Iuserrole IN VARCHAR2, Iuserpassword IN VARCHAR2, Ilogin IN VARCHAR2, Iemail IN VARCHAR2) AS
    BEGIN
    if(trim(Ifirstname) is not null and trim(Ilastname) is not null and trim(Ifirstname) is not null and trim(Ilogin) is not null and trim(Iuserpassword) is not null and trim(Iuserrole) is not null and trim(Iemail) is not null) then
      INSERT INTO A_USER VALUES (seq_User.nextval, Ifirstname, Ilastname, Iuserrole, Iuserpassword, Ilogin, Iemail, null);
    else
      RAISE_APPLICATION_ERROR(-20000, 'Vyplnte vsechny udaje.');
    end if;
  END new_user;



  PROCEDURE new_computer_brand (Icomputer_brand_maker IN VARCHAR2, Icompuer_model IN VARCHAR2) AS
    BEGIN
    if(trim(Icomputer_brand_maker) is not null and trim(Icompuer_model) is not null) then
      INSERT INTO A_COMPUTER_BRAND VALUES (seq_Brand.nextval, Icomputer_brand_maker, Icompuer_model);
    else
      RAISE_APPLICATION_ERROR(-20000, 'Chybne udaje vyrobce pocitace.');
    end if;
  END new_computer_brand;


  PROCEDURE new_computer_parameters (Iextername_gpu IN NUMBER, Ioptical_disk_drive IN NUMBER, Ihdd IN NUMBER, Iprocessor IN VARCHAR2, Iram IN NUMBER) AS
    BEGIN
    if(Iextername_gpu is not null and Ioptical_disk_drive is not null and Ihdd>0 and trim(Iprocessor) is not null and Iram>0) then
      INSERT INTO A_COMPUTER_PARAMETERS VALUES (seq_Parameters.nextval, Iextername_gpu, Ioptical_disk_drive, Ihdd, Iprocessor, Iram);
    else
      RAISE_APPLICATION_ERROR(-20000, 'Chybne udaje parametru pocitace.');
    end if;
  END new_computer_parameters;


  PROCEDURE new_os (Ios_name IN VARCHAR2, Ios_version IN NUMBER) AS
    BEGIN
    if(trim(Ios_name) is not null and Ios_version>0) then
      INSERT INTO A_OS VALUES (seq_OS.nextval, Ios_name, Ios_version);
    else
      RAISE_APPLICATION_ERROR(-20000, 'Chybne udaje OS pocitace.');
    end if;
  END new_os;



  PROCEDURE new_computer (
  Ibpcs_sessions IN VARCHAR2, Icomments IN VARCHAR2, Icreate_time IN DATE, Iguarantees IN DATE, Iinventory_number IN VARCHAR2, Ilast_update_time IN DATE, Imac_address IN VARCHAR2, Icomputer_name IN VARCHAR2, Iserial_number IN VARCHAR2,
  Icomputer_brand_maker IN VARCHAR2, Icompuer_model IN VARCHAR2,
  Iextername_gpu IN NUMBER, Ioptical_disk_drive IN NUMBER, Ihdd IN NUMBER, Iprocessor IN VARCHAR2, Iram IN NUMBER,
  Ios_name IN VARCHAR2, Ios_version IN NUMBER,
  Ifirstname IN VARCHAR2, Ilastname IN VARCHAR2, Iuserrole IN VARCHAR2, Iuserpassword IN VARCHAR2, Ilogin IN VARCHAR2, Iemail IN VARCHAR2) AS    

  glob_maker NUMBER;
  glob_parameters NUMBER;
  glob_os NUMBER;
  glob_user NUMBER;
  glob_seq NUMBER;

    BEGIN  

      BEGIN
      select * into glob_maker from(select a_computer_brand.computer_brand_id from a_computer_brand where Icomputer_brand_maker = a_computer_brand.computer_brand_maker and Icompuer_model=a_computer_brand.compuer_model
      ) where rownum=1;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            new_computer_brand(Icomputer_brand_maker, Icompuer_model);
            SELECT seq_Brand.currval into glob_maker FROM dual;
      END;

      BEGIN
      select * into glob_parameters from(select a_computer_parameters.computer_parameters_id from a_computer_parameters where Iextername_gpu = a_computer_parameters.extername_gpu 
      and Ioptical_disk_drive=a_computer_parameters.optical_disk_drive and Ihdd=a_computer_parameters.hdd and Iprocessor=a_computer_parameters.processor and Iram=a_computer_parameters.ram) where rownum = 1;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            new_computer_parameters(Iextername_gpu, Ioptical_disk_drive, Ihdd, Iprocessor, Iram);
            SELECT seq_Parameters.currval into glob_parameters FROM dual;
      END;

      BEGIN
      select * into glob_os from(select a_os.os_id from a_os where Ios_name = a_os.os_name and Ios_version=a_os.os_version) where rownum = 1;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            new_os(Ios_name, Ios_version);
            SELECT seq_OS.currval into glob_os FROM dual;
      END;

      BEGIN
      select * into glob_user from (select a_user.user_id from a_user where Ifirstname = a_user.user_first_name and Ilastname=a_user.user_last_name and Iuserrole=a_user.user_role and Iuserpassword=a_user.user_password
      and Ilogin=a_user.user_login and Iemail=a_user.user_email_address) where rownum=1;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            new_user(Ifirstname, Ilastname, Iuserrole, Iuserpassword, Ilogin, Iemail);
            SELECT seq_User.currval into glob_user FROM dual;
      END;

      BEGIN
       SELECT seq_Computer.nextval into glob_seq FROM dual;
      END;

      INSERT INTO A_COMPUTER VALUES (glob_seq, Ibpcs_sessions, Icomments, Icreate_time, null, Iguarantees, Iinventory_number, Ilast_update_time, Imac_address, Icomputer_name, 
      Iserial_number, glob_maker, glob_parameters, glob_os, glob_user);

  END new_computer;  

END pocitacova_databaze_api;
/