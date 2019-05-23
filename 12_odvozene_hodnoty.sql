--PRIDANI SLOUPCE PRUMERNY POCET RAM ZE VSECH ZARIZENI UZIVATELE
--SLOUPEC BUDE VLOZEN DO TABULKY UZIVATELU
--globalni promenne
CREATE or replace PACKAGE prumer_package IS
  glob_pom Number;
  glob_del Number;
END;

-- upraveni tabulky uzivatelu
ALTER TABLE a_user ADD prumerne_ram NUMBER DEFAULT 0;


-- prepocitani prumeru RAM vsech uzivatelu
BEGIN
    for X in (SELECT user_id FROM a_user)
    loop

        select sum(p.ram) into prumer_package.glob_pom from a_computer_parameters p join a_computer c on (c.computer_parameters_id=p.computer_parameters_id) join a_user u on (u.user_id=c.user_id)
        where u.user_id=X.user_id and u.user_id=c.user_id and c.computer_parameters_id=p.computer_parameters_id;
        
        
        select count(*) into prumer_package.glob_del from a_computer t join a_user s on (t.user_id=s.user_id) where s.user_id=X.user_id;
        
        UPDATE a_user SET prumerne_ram = prumer_package.glob_pom/prumer_package.glob_del where a_user.user_id=X.user_id;
    end loop;
END;
/


-- vytvoreni triggeru
CREATE OR REPLACE TRIGGER trig_computer
AFTER insert or delete or update
ON a_computer
BEGIN
    for X in (SELECT user_id FROM a_user)
    loop

        select sum(p.ram) into prumer_package.glob_pom from a_computer_parameters p join a_computer c on (c.computer_parameters_id=p.computer_parameters_id) join a_user u on (u.user_id=c.user_id)
        where u.user_id=X.user_id and u.user_id=c.user_id and c.computer_parameters_id=p.computer_parameters_id;
        
        
        select count(*) into prumer_package.glob_del from a_computer t join a_user s on (t.user_id=s.user_id) where s.user_id=X.user_id;
        
        UPDATE a_user SET prumerne_ram = prumer_package.glob_pom/prumer_package.glob_del where a_user.user_id=X.user_id;
    end loop;
END;
/
