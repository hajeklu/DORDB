-- Testovaci skript

spool '11_vystup_spool.txt';

--1) vytvoreni uzivatele
begin
pocitacova_databaze_api.new_user('Radim', 'Kratky', 'Manager', 'DLIo253BOQ3p', 'kratkra1', 'kratkra1@uhk.cz');
end;
/

--2) vytvoreni pocitace
-- Computer brand, computer parameters, OS ani user jeste v databazi NEEXISTUJI
--  -> procedura by je mìla sama vytvoøit
-- Nový poèítaè:
begin
pocitacova_databaze_api.new_computer(
'BPCS_1_FRYCZ-0800, BPCS_2_FRYCZ-0800, BPCS_3_FRYCZ-0800', 'Muj koment', TO_DATE('14.10.2000', 'DD.MM.YYYY'), TO_DATE('14.11.2009', 'DD.MM.YYYY'), 'FRYCZ - 800/813482H1:54:ZN:BH:WD:55', 
TO_DATE('22.05.2019', 'DD.MM.YYYY'), 'H1:54:ZN:BH:WD:55', 'Zkusebni-FRYCZ-0800', '2BQGEQBP19JBK9APG',
  'Lenovo', 'y510p',
  '1', '1', '4096', 'Pentium', '16',
  'Windows 10', '128',
  'Jan', 'Vondracek', 'Manager', 'DLIo253BOQ3p', 'vondr1', 'vondr1@uhk.cz');
end;
/

spool off;




--Overeni spravnosti:

select * from a_user where user_email_address='kratkra1@uhk.cz';
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               

USER_ID 	USER_FIRST_NAME 	USER_LAST_NAME  	USER_ROLE	USER_PASSWORD		USER_LOGIN		USER_EMAIL_ADDRESS
-------------------------------------------------------------------------------------------------------------------------------------------------
2001		Radim			Kratky			Manager		DLIo253BOQ3p		kratkra1		kratkra1@uhk.cz




SELECT * from a_computer where computer_name='Zkusebni-FRYCZ-0800';
SELECT * from a_computer_brand where computer_brand_id=107;
SELECT * from a_computer_parameters where computer_parameters_id=1202;
SELECT * from a_os where os_id=42;
SELECT * from a_user where user_id=2002;


--Vytvoreny pocitac:

COMPUTER_ID 	BPCS_SESSIONS        						COMMENTS        CREATE_T 	DISCARDED_TIME          GUARANTEES 	INVENTORY_NUMBER             		LAST_UPDATE_TIME            	MAC_ADDRESS             COMPUTER_NAME		SERIAL_NUMBER		COMPUTER_BRAND_ID 	COMPUTER_PARAMETERS_ID      	OS_ID    	USER_ID
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
10003		BPCS_1_FRYCZ-0800, BPCS_2_FRYCZ-0800, BPCS_3_FRYCZ-0800		Muj koment	14.10.00				14.11.09	FRYCZ - 800/813482H1:54:ZN:BH:WD:55	22.05.19			H1:54:ZN:BH:WD:55	Zkusebni-FRYCZ-0800	2BQGEQBP19JBK9APG	107			1202				42		2002



--Vytvoreny vyrobce:

COMPUTER_BRAND_ID	COMPUTER_BRAND_MAKER		COMPUER_MODEL
-----------------------------------------------------------------------
107			Lenovo				y510p



--Vytvorene parametry:

COMPUTER_PARAMETERS_ID		EXTERNAME_GPU		OPTICAL_DISK_DRIVE	HDD		PROCESSOR		RAM
------------------------------------------------------------------------------------------------------------------------------
1202				1			1			4096		Pentium			16



--Vytvoreny OS:

OS_ID		OS_NAME		OS_VERSION
---------------------------------------------
42		Windows 10	128



--Vytvoreny uzivatel:

USER_ID		USER_FIRST_NAME		USER_LAST_NAME		USER_ROLE	USER_PASSWORD		USER_LOGIN	USER_EMAIL_ADDRESS
-------------------------------------------------------------------------------------------------------------------------------------------
2002		Jan			Vondracek		Manager		DLIo253BOQ3p		vondr1		vondr1@uhk.cz