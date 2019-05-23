--1) vytvoreni uzivatele
begin
pocitacova_databaze_api.new_user('Radim', 'Kratky', 'Manager', 'DLIo253BOQ3p', 'kratkra1', 'kratkra1@uhk.cz');
end;

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