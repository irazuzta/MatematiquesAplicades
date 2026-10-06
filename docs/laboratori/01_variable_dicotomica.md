# Activitat 1 — Una variable nova: "nit tropical"? (Sí/No)

*Laboratori · Relacionat amb [Bloc 1 — Taules de freqüència](../teoria/01_taules_frequencia.md)*

[:material-file-pdf-box: Descarrega l'activitat (PDF)](../assets/laboratori/Activitat1_Variable_Dicotomica.pdf){ .md-button }

## Context

Recordem d'on venim: treballem amb el registre diari de temperatures i pluviometria de l'estació de **Nulles/Valls** (1950–2025), i el nostre fil conductor és estudiar les **nits tropicals**: nits en què la temperatura mínima (`TN`) no baixa de **20 ºC**.

Fins ara, `TN` és una variable **quantitativa contínua** (pot prendre qualsevol valor decimal: 18,3 ºC, 21,7 ºC...). En aquesta activitat farem una cosa nova: **construirem una variable pròpia** a partir de `TN`, que no estava directament a l'arxiu original. Aquesta nova variable respondrà només a la pregunta *"aquesta nit, va ser tropical?"*, amb dues úniques respostes possibles: **Sí** o **No**.

Una variable amb només dues categories possibles s'anomena **variable dicotòmica** (del grec *dikho-*, "en dos"). És un cas particular de variable **qualitativa nominal** (com les que vam veure al Bloc 1: mitjà de transport, color d'ulls...), però amb només dues opcions. És, de fet, el tipus de variable més senzill possible, i per això la fem servir per introduir la taula de freqüències sobre dades reals.

## Objectius

- Entendre què és una **variable dicotòmica** i com es construeix a partir d'una condició lògica sobre una altra variable.
- Construir, tant a Google Sheets com a R, una taula de freqüències ($n_i$, $f_i$) per a aquesta variable de dos valors.
- Introduir a R el concepte de **vector lògic** (`TRUE`/`FALSE`) i com R el tracta internament com si fossin `1` i `0`.
- Aprendre les funcions `COMPTA.SI` (Sheets) i `table()` (R) per construir taules de freqüències de manera automàtica.

Per simplificar (encara no hem filtrat per mesos d'estiu, això ho farem a l'Activitat 2), en aquesta activitat treballarem **només amb l'any 2020 sencer** com a exemple petit i manejable, abans d'escalar-ho a tota la sèrie.

## Part A — Treballem amb R

Primer fem tot el recorregut amb **R** (RStudio). A la Part B repetirem les mateixes operacions amb **Google Sheets**.

### R · Pas 1 — Aïllar un any concret

```r
any2020 <- subset(dades, ANY == 2020)
nrow(any2020)   # hauria de donar 366 (2020 va ser any de traspàs)
```

**Explicació:**

- `subset(taula, condició)`: la funció `subset()` retorna només les files d'una taula que compleixen una **condició**. Aquí li diem: "de `dades`, queda't només amb les files on `ANY == 2020`".
- `ANY == 2020`: el doble signe `==` és l'operador de **comparació d'igualtat** a R (no s'ha de confondre amb `=`, que en molts contextos s'utilitza per assignar valors a arguments de funcions). `ANY == 2020` es llegeix "és ANY igual a 2020?" i el resultat és, per a cada fila, `TRUE` o `FALSE`.
- `any2020 <-`: guardem el resultat (només les 366 files de l'any 2020) amb un nom nou.

### R · Pas 2 — Construir la variable dicotòmica

Ara, per a cada dia de l'any 2020, volem saber si va ser una nit tropical (TN ≥ 20) o no.

```r
any2020$tropical <- any2020$TN >= 20
head(any2020$tropical, 10)
```

**Explicació pas a pas:**

- `any2020$TN >= 20`: aquesta comparació es fa **per a cada fila alhora**. El resultat no és un sol `TRUE`/`FALSE`, sinó un vector amb tants `TRUE`/`FALSE` com files té `any2020` (366 valors): `TRUE` si aquell dia TN va ser 20 o més, `FALSE` en cas contrari.
- `any2020$tropical <- ...`: aquí fem una cosa nova: en lloc de crear un objecte independent, **afegim una columna nova** a la taula `any2020`, anomenada `tropical`. A R, si assignes un vector a `taula$columna_nova` i aquesta columna encara no existeix, R la crea automàticament.
- `head(any2020$tropical, 10)`: mostra els 10 primers valors d'aquesta nova columna, per comprovar que té sentit (hauries de veure sobretot `FALSE` als mesos d'hivern).

!!! note "Mini manual R: vectors lògics"

    A R, quan comparem números (amb `==`, `>=`, `<`, etc.) el resultat és un **vector lògic**: una seqüència de valors `TRUE` (cert) o `FALSE` (fals). Aquests valors tenen una propietat molt útil: **R els tracta com si fossin `1` i `0`** quan calen fer-hi operacions numèriques. Per exemple:

    ```r
    sum(any2020$tropical)     # suma tots els TRUE com si fossin 1 -> compta quantes nits tropicals hi ha hagut
    mean(any2020$tropical)    # la "mitjana" de TRUE/FALSE -> la PROPORCIÓ de nits tropicals (entre 0 i 1)
    ```

    Aquest "truc" (`TRUE` = 1, `FALSE` = 0) el farem servir moltes vegades durant el curs: és una de les idees més potents de treballar amb dades booleanes (Sí/No) en un llenguatge de programació.

### R · Pas 3 — La taula de freqüències

Ara ja tenim, per a cada dia de l'any 2020, si va ser una nit tropical o no. Construïm la taula de freqüències d'aquesta variable dicotòmica.

**La funció `table()`**

```r
table(any2020$tropical)
```

Aquesta única instrucció ja et dona la freqüència absoluta ($n_i$) de cada categoria (quants `FALSE` i quants `TRUE` hi ha). Per obtenir directament la freqüència relativa ($f_i$):

```r
prop.table(table(any2020$tropical))
```

**Explicació:**

- `table(vector)`: compta quantes vegades apareix cada valor diferent dins d'un vector, i retorna el resultat com una petita taula. És l'equivalent, en una sola funció, de construir tota la columna $n_i$ d'una taula de freqüències.
- `prop.table(taula)`: agafa una taula de freqüències absolutes (com la que retorna `table()`) i la converteix en freqüències **relatives**, dividint cada valor pel total. És exactament $f_i = n_i / N$.

Amb dues línies de codi, doncs, obtenim el mateix que trigaríem una estona a construir a mà.

## Part B — Treballem amb Google Sheets

Ara fem el mateix amb el full de càlcul, partint de les dades que ja vas importar a l'Activitat 0.

### Sheets · Pas 1 — Aïllar un any concret

Si a l'Activitat 0 vas deixar totes les dades (1950–2025) en un mateix full, la manera més senzilla d'aïllar un any és amb un **filtre**. Selecciona tota la taula i aplica **Dades → Crea un filtre**; després, a la columna `ANY`, desmarca "Selecciona-ho tot" i marca només **2020**.

Alternativament, més endavant (Activitat 2) aprendrem la funció `FILTRA`, que ens permetrà fer-ho amb una fórmula, sense fer clic manualment. De moment, el filtre manual és suficient.

### Sheets · Pas 2 — Construir la variable dicotòmica

Amb el filtre de l'any 2020 actiu, crea una columna nova (per exemple a la columna `G`, si `F` és `TN`) amb la fórmula:

```
=SI(F2>=20; "Sí"; "No")
```

**Explicació:**

- `SI(condició; valor_si_cert; valor_si_fals)`: la funció `SI` (en anglès `IF`) avalua la condició; si és certa, retorna el primer valor ("Sí"), i si és falsa, retorna el segon ("No").
- `F2>=20`: la condició, comparant la cel·la de temperatura mínima d'aquella fila amb 20.
- Arrossega la fórmula cap avall (o selecciona la cel·la i fes doble clic al quadradet inferior dret) perquè s'apliqui a totes les files de l'any 2020.

### Sheets · Pas 3 — La taula de freqüències

**`COMPTA.SI`**

```
=COMPTA.SI(G2:G367;"Sí")
=COMPTA.SI(G2:G367;"No")
```

**Explicació:**

- `COMPTA.SI(rang; criteri)`: compta quantes cel·les del rang compleixen el criteri indicat. `COMPTA.SI(G2:G367;"Sí")` compta quantes cel·les de la columna `G` (la nostra variable Sí/No) contenen exactament el text `"Sí"`.
- Per obtenir la freqüència relativa, divideix aquest resultat pel total de dies: `=COMPTA.SI(G2:G367;"Sí")/366`.

## La taula completa

Amb qualsevol de les dues eines hauries d'arribar (per a l'any 2020, mesos d'hivern inclosos) a una taula com aquesta:

| Nit tropical? | $n_i$ | $f_i$ | $f_i$ (%) |
|---|---|---|---|
| No | 345 | 0,943 | 94,3% |
| Sí | 21 | 0,057 | 5,7% |
| **Total** | **366** | **1,00** | **100%** |

*(Comprova que els teus resultats coincideixen amb aquests valors —si no, revisa els passos anteriors abans de continuar.)*

**Interpretació:** de les 366 nits de l'any 2020, 21 van superar els 20 ºC de mínima. Fixa't, però, que aquest 5,7% barreja hivern i estiu: és evident que cap nit de gener serà tropical, així que aquest percentatge està "diluït" per mesos on el fenomen és impossible. A l'Activitat 2 solucionarem això, quedant-nos només amb els mesos d'estiu.

## Per practicar

Repeteix el procés (tant a R com a Sheets) per a un altre any de la teva elecció (per exemple, 1985 o 2005) i respon:

a) Quantes nits tropicals hi va haver aquell any?

b) Per què creus que comparar directament aquest percentatge entre dos anys diferents (any sencer, hivern inclòs) pot ser enganyós?

c) Amb el "truc" `TRUE`=1/`FALSE`=0 explicat al mini manual, calcula `sum(any2020$tropical)` i comprova que dona el mateix resultat que `table(any2020$tropical)` per a la categoria `TRUE`.

## Resum de l'activitat

- Hem creat una **variable dicotòmica** pròpia (nit tropical: Sí/No) a partir d'una condició lògica sobre `TN`.
- A R, hem après que comparar números genera un **vector lògic** (`TRUE`/`FALSE`), i que R els tracta com `1`/`0` en operacions numèriques.
- Hem construït la taula de freqüències ($n_i$, $f_i$) amb `table()` i `prop.table()` a R, i amb `COMPTA.SI` a Sheets.
- Hem detectat un problema metodològic: barrejar hivern i estiu dilueix el fenomen que volem estudiar.

**Següent pas (Activitat 2):** aprendrem a filtrar les dades perquè es quedin només amb els mesos d'estiu, abans de tornar a construir la taula de freqüències.
