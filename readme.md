# Zadanie 3 - XML prezentácia
Pre potreby vytvorenia jednoduchej prezentácie sme identifikovali 4 najpodstatnejšie druhy slajdov: s textom, s obrázkom, s odrážkami a s číslovaným zoznamom. Štruktúra dokumentu je opísaná pomocou XSD Schema a obsahuje nasledujúce elementy:

- ```<prezentacia>``` - koreňový element dokumentu, obsahujúci:
  - práve jeden element ```<info>``` - element s informáciami o prezentácii, obsahujúci:
    - práve jeden element ```<nazov>``` - element s názvom prezentácie (napr. na úvodnom slajde),
    - najviac jeden element ```<podnadpis>``` - element s podtitulom prezentácie (na úvodný slajd) - nepovinný,
    - najviac jeden element ```<autor>``` - element s menom autora (na úvodný slajd) - nepovinný.
  - aspoň jeden element ```<slajd>``` - element reprezentujúci jednu snímku v prezentácii, obsahujúci:
    - jeden z nasledujúcich elementov pre druh slajdu:
      - ```<text>``` - element pre slajd obsahujúci obyčajný text, obsahujúci text na zobrazenie,
      - ```<obrazok>``` - element pre slajd obsahujúci obrázok s popisom, obsahujúci:
        - popis obrázku (text vo vnútri elementu),
        - povinný atribút ```zdroj``` obsahujúci URI obrázka.
      - ```<zoznam>``` - element pre slajd so zoznamom, obsahujúci:
        - aspoň jeden element ```<polozka-zoznamu>``` - textový element s obsahom jedného bodu v zozname,
        - povinný atribút ```cislovany``` typu ```boolean``` určujúci, či ide o zoradený (číslovaný) zoznam, alebo nezoradený (odrážky)
      - povinný atribút ```nadpis``` určujúci nadpis príslušného slajdu.

## Transformácia do XHTML
Na transformáciu do XHTML je použitá verzia 2.0 XSLT, kvôli jednoduchému rozdeleniu výstupu do viacerých súborov. Použitý prekladač teda musí túto verziu podporovať. Pri tvorbe bol použitý Saxon 9HE. Transformáciu spustíme dávkovým súborom ```transform_xhtml.bat``` s dvoma parametrami: názov zdrojového súboru (.xml) a názov súboru s transformáciou (.xsl). V skripte treba zmeniť cestu k saxonu (4. riadok), taktiež treba mať javu v PATH-e. 
```
transform_xhtml.bat prezentacia.xml do-xhtml.xsl
```

Pri transformácii sa používajú nasledovné šablóny:
- Šablóna pre koreňový element, v ktorej sa volá najprv šablóna pre element ```<info>``` na vytvorenie úvodnej stránky a následne pre elementy ```<slajd>```.
- Šablóna pre element ```<info>``` vytvorí prvú stránku prezentácie s nadpisom, podnadpisom a menom autora (použitím elementu ```<xsl:value-of>``` na príslušné elementy) a odkazom na prvý slajd.
- Šablóna pre element ```<slajd>```. Použitý element ```<xs:result-document>``` spolu s nastavením názvu súboru podľa pozície spracovávaného elementu zabezpečí, že každý slajd bude v samostatnom súbore. Táto šablóna vytvorí kostru výsledného XHTML dokumentu s hlavičkou, základným rozložením stránky vrátane stránkovania, nadpisu a horizontálneho oddeľovača. 
- Šablóna pre generovanie obsahu.
- Šablóny pre jednotlivé druhy slajdov.

Na štýlovanie stránok je opäť raz použitý [Bootstrap](https://getbootstrap.com/), tmavá téma je z [Bootswatch](https://bootswatch.com/).

## Transformácia do PDF
Pri transformácii do PDF sa používajú dve rôzne rozloženia strán: pre titulný slajd a pre ostatné. Pre generovanie obsahu prezentácie sa používa rovnaká šablóna ako pre číslovaný zoznam. Používajú sa obdobné šablóby ako pri transformácii do XHTML. Transformáciu spustíme dávkovým súborom ```transform_pdf.bat``` s dvoma parametrami: názov zdrojového súboru (.xml) a názov súboru s transformáciou (.xsl). V skripte treba zmeniť cestu k saxonu (4. riadok), taktiež treba mať javu v PATH-e. 
```
transform_pdf.bat prezentacia.xml do-fo.xsl
```

## Parametre transformácií
Parametre transformácií sú uložené v súbore ```parametre.xml```.
- ```<obsah>``` je booleovská hodnota určujúca, či sa má generovať stránka s obsahom,
- ```<generovat-titulny-slajd>``` je booleovská hodnota určujúca, či sa má generovať titulný slajd,
- ```<cislovanie-slajdov>``` je booleovská hodnota určujúca, či má na slajdoch byť číslovanie,
- ```<tmava-tema>``` je booleovská hodnota určujúca, či sa má použiť tmavá téma (len pri transformácii do XHTML)
- ```<titulny-slajd>``` je textová hodnota určujúca, čo sa má vygenerovať na titulnom slajde (defaultná hodnota, pri ktorej sa vygeneruje všetko je ```nazov,podnadpis,oddelovac,autor```)