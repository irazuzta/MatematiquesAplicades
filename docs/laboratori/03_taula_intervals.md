# Activitat 3 — La temperatura mínima amb intervals

*Laboratori · Relacionat amb [Bloc 1 — Taules de freqüència](../teoria/01_taules_frequencia.md)*

[:material-file-pdf-box: Descarrega l'activitat (PDF)](../assets/laboratori/Activitat3_Taula_Intervals.pdf){ .md-button }

## Context

Fins ara hem reduït la temperatura mínima (`TN`) a una variable dicotòmica (nit tropical: Sí/No). Això és útil per contar quantes nits superen els 20 ºC, però ens fa perdre molta informació: no és el mateix una nit de 20,1 ºC que una de 24,5 ºC, i totes dues compten igual com a "Sí".

En aquesta activitat tornarem a `TN` tal com és: una **variable quantitativa contínua**. Com vam veure al Bloc 1 amb l'exemple de les alçades dels 30 alumnes, quan una variable és contínua **no té sentit fer una fila per cada valor exacte** (gairebé cada nit té una TN lleugerament diferent de les altres): cal **agrupar en intervals**.

Per tenir un conjunt de dades manejable i recent, en aquesta activitat treballarem amb **les nits d'estiu del període 2020–2025** (6 anys × 122 nits = 732 nits en total), el mateix subconjunt que vam obtenir filtrant a l'Activitat 2 (però ara afegint també un filtre per anys).

## Objectius

- Repassar i aplicar els conceptes del Bloc 1 sobre taules amb intervals: **amplitud**, **límits [a, b)** i **marca de classe**.
- Construir, amb R i amb Sheets, una taula de freqüències amb intervals per a la variable `TN` (nits d'estiu 2020–2025).
- Conèixer la funció `cut()` de R, que assigna automàticament cada valor al seu interval.
- Introduir la funció `FREQÜÈNCIA` de Google Sheets (una fórmula matricial, diferent de les que hem vist fins ara).

## Part A — Treballem amb R

Primer fem tot el recorregut amb **R** (RStudio). A la Part B repetirem les mateixes operacions amb **Google Sheets**.

### R · Pas 1 — Preparar el subconjunt de dades

```r
recent <- subset(dades, ANY >= 2020 & MES %in% c(6, 7, 8, 9))
nrow(recent)   # hauria de donar 732
range(recent$TN)   # el valor mínim i màxim de TN en aquest període
```

**Explicació:**

- `ANY >= 2020 & MES %in% c(6, 7, 8, 9)`: aquí combinem **dues condicions** amb l'operador `&` ("i"): l'any ha de ser 2020 o posterior, **i** el mes ha de ser un dels quatre d'estiu. Totes dues s'han de complir alhora perquè la fila es quedi.
- `range(vector)`: una funció nova que retorna, en un sol resultat, el valor mínim i el màxim d'un vector. Ens servirà per decidir com construir els intervals: `range(recent$TN)` dona 8,5 ºC de mínim i 24,5 ºC de màxim en aquest període, així que ja podem triar uns límits d'interval que ho cobreixin tot.

### R · Pas 2 — Triar els intervals

Igual que al Bloc 1 (recorda l'exemple de les alçades, intervals de 5 cm des de 155 cm), hem de triar una **amplitud** i un **punt de partida** que cobreixi tot el rang observat (8,5 a 24,5 ºC, segons el `range()` del Pas 1). Per a la temperatura mínima d'estiu, uns intervals raonables són d'**amplitud 2 ºC**, començant a **8 ºC** (per sota del valor mínim observat):

$$[8,10),\ [10,12),\ [12,14),\ [14,16),\ [16,18),\ [18,20),\ [20,22),\ [22,24),\ [24,26)$$

Fixa't que l'interval $[20,22)$ és exactament el que separa les nits tropicals (TN ≥ 20) de les que no ho són: la línia divisòria de la nostra variable dicotòmica de les Activitats 1 i 2 coincideix amb un límit d'interval, cosa que no és casualitat: hem triat l'amplitud i el punt de partida precisament perquè fos així.

!!! note "Compte: els intervals han de cobrir tot el rang de dades"

    Si tries un punt de partida per sobre del valor mínim real (per exemple,
    començar a 14 ºC quan el `range()` del Pas 1 diu que hi ha nits de fins a 8,5
    ºC), les funcions `cut()` i `FREQÜÈNCIA` deixaran **fora de qualsevol interval**
    els valors per sota del primer límit (a R, hi assignaran `NA`). El resultat és
    una taula que sembla correcta —perquè les categories que sí que apareixen
    tenen bon aspecte— però que en realitat **no compta totes les dades**: la suma
    de les $n_i$ seria inferior al total real de files. Per això el primer pas
    sempre ha de ser mirar el `range()` de les dades *abans* de triar els límits
    dels intervals.

### R · Pas 3 — Assignar cada valor al seu interval, amb `cut()`

```r
recent$interval <- cut(recent$TN, breaks = seq(8, 26, by = 2), right = FALSE)
table(recent$interval)
```

**Explicació pas a pas:**

- `seq(8, 26, by = 2)`: la funció `seq()` (de *sequence*, "seqüència") genera una successió de números, aquí: `8, 10, 12, 14, 16, 18, 20, 22, 24, 26`. Aquests seran els **límits** dels nostres intervals.
- `cut(vector, breaks = ...)`: la funció `cut()` ("tallar") agafa un vector numèric continu i el converteix en una variable categòrica, assignant cada valor a l'interval que li correspon segons els `breaks` indicats.
- `right = FALSE`: per defecte, `cut()` construeix intervals **tancats per la dreta**, és a dir $(a, b]$. Com que al Bloc 1 hem après el conveni contrari ($[a, b)$, tancat per l'esquerra), indiquem `right = FALSE` perquè `cut()` faci servir aquest conveni.
- `recent$interval <- ...`: afegim una columna nova a la taula, com ja vam fer amb `tropical` a l'Activitat 1, però ara amb el nom de l'interval en lloc de `TRUE`/`FALSE`.
- `table(recent$interval)`: com ja sabem, compta quantes vegades apareix cada categoria —en aquest cas, cada interval— és a dir, ens dona directament la columna $n_i$ de la taula de freqüències.

!!! note "Mini manual R: de $n_i$ a $F_i$ amb `cumsum()`"

    Un cop tenim les freqüències absolutes amb `table()`, per obtenir les **acumulades** ($N_i$, $F_i$) no cal fer-ho a mà: R té la funció `cumsum()` ("suma acumulada"), que retorna, per a cada posició, la suma de tots els valors fins aquell punt:

    ```r
    n_i <- table(recent$interval)
    N_i <- cumsum(n_i)        # freqüència absoluta acumulada
    f_i <- n_i / sum(n_i)      # freqüència relativa
    F_i <- cumsum(f_i)        # freqüència relativa acumulada
    ```

    Per exemple, si `n_i` fos `c(3, 5, 2)`, `cumsum(n_i)` donaria `c(3, 8, 10)`: el primer valor no canvia, el segon és 3+5, el tercer és 3+5+2. És exactament la mateixa lògica que quan omplim a mà la columna $N_i$ d'una taula de freqüències, però calculada automàticament.

## Part B — Treballem amb Google Sheets

Ara fem el mateix amb el full de càlcul, partint de les dades que ja vas importar a l'Activitat 0.

### Sheets · Pas 1 — Preparar el subconjunt de dades

Amb `FILTRA` (ja el vam veure a l'Activitat 2), ara amb dues condicions combinades amb `*` (que fa la mateixa funció que `&` a R: només val 1 —"cert"— si totes dues comparacions valen 1 alhora):

```
=FILTRA(A2:F27760; (A2:A27760>=2020) * ((B2:B27760=6)+(B2:B27760=7)+(B2:B27760=8)+(B2:B27760=9)))
```

### Sheets · Pas 2 — La funció `FREQÜÈNCIA`

A diferència de `COMPTA.SI` (que aplicàvem un cop per cada categoria), `FREQÜÈNCIA` calcula **totes les freqüències d'un cop**, a partir dels límits superiors dels intervals. És una fórmula una mica especial: és una **fórmula matricial** (retorna diversos resultats alhora, un per fila).

1. En una columna auxiliar, escriu els límits superiors dels intervals: `10`, `12`, `14`, `16`, `18`, `20`, `22`, `24`, `26`.
2. Selecciona un rang buit de 9 cel·les (una per cada interval) a la columna del costat.
3. Escriu la fórmula i, en lloc de prémer només Enter, prem **Ctrl+Maj+Enter** (perquè Sheets sàpiga que ha d'omplir totes les cel·les seleccionades alhora):

```
=FREQÜÈNCIA(TN_estiu_2020_25; {10;12;14;16;18;20;22;24;26})
```

**Explicació:**

- `FREQÜÈNCIA(dades; límits)`: compta, per a cada límit de la llista, quants valors de `dades` són **més grans que el límit anterior i menors o iguals que aquest**. És a dir, fa servir el conveni $(a, b]$ (a diferència del `cut()` de R, que hem configurat com $[a, b)$): com que les nostres temperatures tenen un sol decimal, molts valors cauen exactament sobre un límit (per exemple, hi ha 55 nits amb TN = 20,0 ºC) i la diferència de conveni **sí que canvia els recomptes** (vegeu la nota després de la taula).
- `{10;12;14;16;18;20;22;24;26}`: una manera d'escriure directament una llista de valors dins la fórmula, sense necessitat d'una columna auxiliar (els punts i coma separen els valors).

## La taula completa (nits d'estiu, 2020–2025, n = 732)

Amb R (`cut()` amb `right = FALSE`) hauries d'arribar a aquesta taula:

| Interval | Marca de classe | $n_i$ | $f_i$ | $f_i$ (%) |
|---|---|---|---|---|
| [8, 10) | 9 | 5 | 0,007 | 0,7% |
| [10, 12) | 11 | 11 | 0,015 | 1,5% |
| [12, 14) | 13 | 31 | 0,042 | 4,2% |
| [14, 16) | 15 | 95 | 0,130 | 13,0% |
| [16, 18) | 17 | 136 | 0,186 | 18,6% |
| [18, 20) | 19 | 248 | 0,339 | 33,9% |
| [20, 22) | 21 | 139 | 0,190 | 19,0% |
| [22, 24) | 23 | 65 | 0,089 | 8,9% |
| [24, 26) | 25 | 2 | 0,003 | 0,3% |
| **Total** | — | **732** | **1,00** | **100%** |

**Interpretació:** l'interval més freqüent és $[18,20)$, just per sota del llindar de nit tropical: és a dir, moltíssimes nits d'estiu recents s'hi acosten sense arribar-hi. Si sumem els tres intervals a partir de 20 ºC (139 + 65 + 2 = 206 nits), recuperem exactament el nombre de nits tropicals del període 2020–2025 que ja coneixíem per l'enfocament dicotòmic —una bona manera de comprovar que els dos mètodes són coherents entre si. Fixa't també que les tres nits més fredes de tot el període (per sota de 14 ºC, als intervals $[8,10)$, $[10,12)$ i $[12,14)$) només sumen 47 nits: són poques, però un conjunt d'intervals que no les cobrís les hauria fetes desaparèixer silenciosament de la taula, en comptes de mostrar-les com el que són —nits d'estiu, però fresques.

!!! warning "Compte: `FREQÜÈNCIA` no dona exactament aquesta taula"

    Amb els límits `{10;12;…;26}`, `FREQÜÈNCIA` fa servir el conveni $(a, b]$ i els recomptes
    surten diferents: 9, 12, 37, 124, 173, 226, 120, 30 i 1 (en lloc de 5, 11, 31, 95,
    136, 248, 139, 65 i 2). Per exemple, les 55 nits amb TN = 20,0 ºC (que sí que són
    tropicals) queden a l'interval $(18,20]$ i no a $[20,22)$; amb `FREQÜÈNCIA` només
    se'n comptarien 151 de tropicals, no 206. Com que `TN` té un sol decimal, per
    obtenir els mateixos recomptes que amb `cut()` pots fer servir com a límits els
    valors menys 0,1 (9,9; 11,9; …; 25,9), ja que $x<10$ equival a $x\le 9{,}9$.

## Per practicar

a) Calcula la freqüència absoluta acumulada ($N_i$) i la relativa acumulada ($F_i$) de la taula anterior. Quin percentatge de nits d'estiu (2020–2025) va tenir una TN inferior a 20 ºC?

b) Per què la marca de classe de l'interval $[8,10)$ és 9 i no 8 o 10? Repassa la definició del Bloc 1 si cal.

c) Si en comptes d'amplitud 2 haguéssim triat amplitud 5 (com a l'exemple de les alçades del Bloc 1), quants intervals ens quedarien, aproximadament, per cobrir el rang de `TN` d'aquest període? Prova-ho amb `cut(recent$TN, breaks = seq(5, 30, by = 5), right = FALSE)` (fixa't que el punt de partida, 5, torna a quedar per sota del mínim real, 8,5 ºC, pel mateix motiu explicat al Pas 2).

## Resum de l'activitat

- Hem après a construir una taula de freqüències **amb intervals** per a una variable contínua, aplicant els conceptes del Bloc 1 (amplitud, límits $[a,b)$, marca de classe) sobre dades reals.
- A R, hem fet servir `cut()` per assignar cada valor al seu interval, i `cumsum()` per obtenir les freqüències acumulades.
- A Sheets, hem après la fórmula matricial `FREQÜÈNCIA`, que calcula totes les freqüències d'un sol cop.
- Hem comprovat que l'enfocament amb intervals i l'enfocament dicotòmic (Activitats 1–2) són coherents: sumant els intervals a partir de 20 ºC recuperem el recompte de nits tropicals.
- Hem après per què els intervals han de cobrir sempre tot el rang observat (`range()` abans de triar els límits), per no deixar dades fora de la taula sense adonar-nos-en.

**Següent pas (Activitat 4):** agruparem les dades per **dècada** (no només per any concret) i compararem com ha evolucionat el nombre de nits tropicals al llarg de tota la sèrie 1950–2025.
