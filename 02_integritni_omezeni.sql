/*
A) Trivi�ln� integritn� omezen�
Tabulka A_Computer
Atribut discarded_time mus� b�t v�t�� ne� create_time.
Atribut guarantees mus� b�t v�t�� ne� create_time.
Atribut last_update_time mus� b�t v�t�� ne� create_time.
Atribut mac_address mus� b�t nepr�zdn� a unik�tn� - zaji�t�no unik�tn�m kl��em.
Atribut computer_name nesm� b�t pr�zdn�.

Tabulka A_User
Atribut user_first_name nesm� b�t pr�zdn�.
Atribut user_last_name nesm� b�t pr�zdn�.
Atribut user_email_address mus� m�t podobu emailov� adresy a mus� b�t unik�tn�.
Atribut user_login mus� b�t nenulov� �et�z a mus� b�t unik�tn� - zaji�t�no unik�tn�m kl��em
Atribut user_password nesm� b�t pr�zdn�.
Atribut user_role nesm� b�t pr�zdn�.

Tabulka A_Computer_parameters
Atribut hdd > 0
Atribut ram > 0
Atribut extername_GPU nesm� b�t pr�zdn�.
Atribut optical_disk_drive nesm� b�t pr�zdn�.
Atribut processor nesm� b�t pr�zdn�.

Tabulka A_OS
Atribut os_name nesm� b�t pr�zdn�.
Atribut os_version > 0


B) Netrivi�ln� integritn� omezen�
Tabulka A_Computer
Jsou-li v tabulce A_Computer_brand vypln�ny atributy computer_brand_maker a computer_model pro dan� po��ta�, pak mus� b�t v tabulce A_Computer vypln�n i atribut serial_number
*/