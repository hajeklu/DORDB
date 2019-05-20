/*
 objektový pøístup
*/

create type t_user as object(
    user_id NUMBER,
    user_first_name VARCHAR2(255),
    user_last_name VARCHAR2(255),
    user_role VARCHAR2(50),
    user_password VARCHAR2(255),
    user_login VARCHAR2(255),
    user_email_address VARCHAR2(255)
);

create type t_os as object(
    os_id NUMBER,
    os_name VARCHAR(255),
    os_version NUMBER
);

create type t_computer_parameters as object(
    computer_parameters_id NUMBER,
    extername_GPU NUMBER(1,0),
    optical_disk_drive NUMBER(1,0),
    hdd NUMBER,
    processor VARCHAR(255),
    ram NUMBER
);

create type t_computer_brand as object(
    computer_brand_id NUMBER,
    computer_brand_maker VARCHAR2(255),
    compuer_model VARCHAR2(255)
);

create type t_computer as object(
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
   computer_brand ref t_computer_brand,
   computer_parameters ref t_computer_parameters,
   os ref t_os,
   usr ref t_user
);

create table obj_a_computer_brand of t_computer_brand;
create table obj_a_computer_parameters of t_computer_parameters;
create table obj_a_user of t_user;
create table obj_a_os of t_os;
create table obj_a_computer of t_computer;