/*
 objektový pøístup
*/

create or replace type t_user as object(
    user_id NUMBER,
    user_first_name VARCHAR2(255),
    user_last_name VARCHAR2(255),
    user_role VARCHAR2(50),
    user_password VARCHAR2(255),
    user_login VARCHAR2(255),
    user_email_address VARCHAR2(255)
);

create or replace type t_os as object(
    os_id NUMBER,
    os_name VARCHAR(255),
    os_version NUMBER
);

create or replace type t_computer_parameters as object(
    computer_parameters_id NUMBER,
    extername_GPU NUMBER(1,0),
    optical_disk_drive NUMBER(1,0),
    hdd NUMBER,
    processor VARCHAR(255),
    ram NUMBER
);

create or replace type t_computer_brand as object(
    computer_brand_id NUMBER,
    computer_brand_maker VARCHAR2(255),
    compuer_model VARCHAR2(255)
);

create or replace type t_computer as object(
   computer_id NUMBER,
   bpcs_seassions VARCHAR2(255),
   comments VARCHAR2(1023),
   create_time DATE,
   discarded_time DATE,
   guarantees DATE,
   inventory_number VARCHAR2(255),
   last_update_time DATE,
   mac_address VARCHAR2(255),
   computer_name VARCHAR2(255),
   serial_number VARCHAR2(255),
   computer_brand_id ref t_computer_brand,
   computer_parameters_id ref t_computer_parameters,
   os_id ref t_os,
   user_id ref t_user
);

create table obj_a_computer_brand of t_computer_brand;
create table obj_a_computer_parameters of t_computer_parameters;
create table obj_a_user of t_user;
create table obj_a_os of t_os;
create table obj_a_computer of t_computer;


-- napleni objektovych tabulek
INSERT INTO OBJ_A_OS SELECT * FROM A_OS;
INSERT INTO OBJ_A_USER SELECT * FROM A_USER;
INSERT INTO OBJ_A_COMPUTER_BRAND SELECT * FROM A_COMPUTER_BRAND;
INSERT INTO OBJ_A_COMPUTER_PARAMETERS SELECT * FROM A_COMPUTER_PARAMETERS;

INSERT INTO OBJ_A_COMPUTER SELECT z.computer_id,z.bpcs_sessions,z.comments,z.create_time,z.discarded_time,z.guarantees,z.inventory_number,z.last_update_time,z.mac_address,z.computer_name,z.serial_number,
(SELECT REF (o) FROM OBJ_A_COMPUTER_BRAND o WHERE o.computer_brand_id = z.computer_brand_id),(SELECT REF (o) FROM OBJ_A_COMPUTER_PARAMETERS o WHERE o.computer_parameters_id = z.computer_parameters_id) 
,(SELECT REF (o) FROM OBJ_A_OS o WHERE o.os_id = z.os_id),(SELECT REF (o) FROM OBJ_A_USER o WHERE o.user_id = z.user_id) 
FROM A_COMPUTER z ;
