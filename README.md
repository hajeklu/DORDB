Projekt, který studenti odevzdají, se bude skládat z následujících částí:
1. Obrázek s modelem (E-R diagram)
 musí obsahovat minimálně 4 entity, lze použít model z vlastních předchozích
semestrálních prací apod. Doporučena jsou originální zadání (nikoliv různé knihovny,
databáze CD/DVD, autobazary, apod.)
2. Slovní popis dodatečných integritních omezení
 např. že plat musí být kladné číslo; že množství pracovníku v místnosti nemůže
překročit kapacitu místnosti apod. (nepočítáme I.O. jako „unikátní“ nebo „cizí klíč“
nebo omezení velikosti položky u řetězců nebo čísel)
 vyžadováno alespoň jedno „triviální omezení“ (jako např. plat > 0) a jedno
„netriviální“ omezení (vztahem k jiné tabulce, agregační funkce jako v příkladu
s kapacitou apod.)
3. Slovní návrh API rozhraní „business logiky“ pro dva procesy, jako např. přijetí zaměstnance =
založení záznamu zaměstnance, svázání s nadřízeným, svázání se sdíleným služebním vozem
(vazba N:M), založení požadavku na koupi pracovních pomůcek (jeden notebook, jedna myš).
Procesy by měly být složitější, než jen takové, které vedou na jeden update či insert
v proceduře.
 Uveďte procedury, jejich parametry, slovní popis činnosti
2
4. Pět slovně formulovaných dotazů nad schématem – musí se jednat o různorodé netriviální
dotazy (navrhněte dotazy vedoucí na použití poddotazů, vnějších spojení, množinových
operací, agregací, atd.)
5. Skript, který vytvoří databázové schéma odpovídající E-R diagramu z bodu 1
6. Skript, který vytvoří v databázovém schématu dodatečná integritní omezení z bodu 2
 netriviální omezení budou realizována pomocí triggerů, které budou volat uložené
procedury provádějící kontrolu; porušení I.O. způsobí vyhození vlastní vyjímky
7. Skript, který naplní tabulky testovacími daty – tabulky by měly obsahovat řádově tisíce řádků
(pro generování testovacích dat můžete použít různé již hotové nástroje, např.
http://www.generatedata.com/#generator ).
8. Skript (včetně výstupu spool), který provede postupně všechny navržené dotazy z bodu 4
 z výstupu bude patrný dotaz, jeho exekuční plán (použijte SET AUTOTRACE ON) a
výsledek
 u dvou (dle úvahy) nejsložitějších dotazů se pokuste vymyslet ještě druhou verzi
dotazu (vracející tentýž výsledek), a porovnáním (podle cost) exekučních plánů
(budou opět součástí výstupu) posuďte, který dotaz byl efektivnější
9. Skript, který se pokusí porušit postupně všechna dodatečná integritní omezení + výstup spool
z provádění tohoto skriptu (budou vidět chyby při porušení I.O.)
10. Skript pro vytvoření balíku (package) a procedur „business logiky“ z bodu 3
11. Testovací skript (včetně výstupu spool obdrženého po spuštění) pro obě procedury, včetně
souvisejících dotazů, které ověří, že každá procedura provedla to co měla
12. Skript, který doplní do zvolené tabulky schématu sloupec, který bude obsahovat odvozené
hodnoty (průměrný plat zaměstnance v rámci oddělní apod.) – tyto hodnoty budou
automaticky aktualizovány pomocí triggerů
13. Skript, který vytvoří úložiště ještě jednou v „objektové“ podobě:
 místo relačních tabulek budou použity uživatelsky definované typy Object a
objektové tabulky (s jinými názvy než v dosavadním modelu)
 objektové tabulky budou naplněny importem z původních relačních tabulek
 datové cizí klíče budou nahrazeny referencemi na objekt
14. Skript, který provede navržených pět dotazů znovu, tentokrát nad objektovými tabulkami
(operace Join bude nahrazena využitím objektových referencí a dereferencí atd.)
 požadovaný výstup stejně jako v „neobjektové“ verzi
3
15. Navrhněte slovně fakta a dimenze pro datový sklad vycházející z vaší databáze. Popište,
k jakým analýzám bude možné tento sklad využít. Identifikujte tabulky/sloupce, ke kterým
bude nutné v datovém skladu navíc evidovat historické hodnoty (pokud již v provozní
databázi nejsou k dispozici).
