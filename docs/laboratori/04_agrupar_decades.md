# Activitat 4 — Agrupar per dècades: com ha evolucionat el fenomen?

*Laboratori · Relacionat amb [Bloc 1 — Taules de freqüència](../presentacions/01_taules_frequencia.md)*

[:material-file-pdf-box: Descarrega l'activitat (PDF)](../assets/laboratori/Activitat4_Agrupar_Decades.pdf){ .md-button }

## Context

Ja sabem calcular, per a qualsevol subconjunt de dades, quantes nits tropicals hi ha
hagut (Activitats 1–2) i com es distribueix la temperatura mínima en intervals
(Activitat 3). Ara farem el pas que dona sentit a tot el projecte: en lloc de mirar
un any concret o un període arbitrari, **agruparem totes les dades d'estiu
(1950–2025) per dècades** i les compararem entre si. Això ens permetrà respondre la
pregunta de fons: *les nits tropicals, han anat a més al llarg dels darrers 75 anys a
Nulles?*

Necessitarem, doncs, una nova variable: la **dècada** a la qual pertany cada any
(1950, 1960, 1970... fins a 2020). No existeix directament a l'arxiu original —
l'haurem de calcular a partir de `ANY`—, de la mateixa manera que a l'Activitat 1 vam
calcular "nit tropical" a partir de `TN`.

## Objectius

- Calcular una nova variable, la **dècada**, a partir de `ANY`, fent servir la divisió entera.
- Aprendre la funció `aggregate()` de R, que permet calcular un resum (per exemple, una suma) **per grups**, sense haver de filtrar dècada per dècada a mà.
- Construir la taula de freqüències final del projecte: nombre (i percentatge) de nits tropicals per dècada.
- A Sheets, introduir les **taules dinàmiques**, l'eina pensada exactament per a aquest tipus de resum "agrupa i calcula".

## Pas 1 — Calcular la dècada: divisió entera

Volem que l'any 1987 es converteixi en 1980, que 1953 es converteixi en 1950, que
2024 es converteixi en 2020, etc. Aquest càlcul es pot fer amb l'operador de
**divisió entera** de R, `%/%`:

```r
estiu$decada <- (estiu$ANY %/% 10) * 10
head(estiu$decada, 3)
```

**Explicació:**

- `%/%`: mentre que `/` fa una divisió normal (amb decimals: `1987 / 10 = 198.7`), l'operador `%/%` fa una **divisió entera**: es queda només amb la part sencera del quocient, descartant el residu (`1987 %/% 10 = 198`).
- `(estiu$ANY %/% 10) * 10`: dividim per 10 (perdent l'últim dígit de l'any) i tornem a multiplicar per 10 (recuperant els zeros al final). El resultat: `1987 → 198 → 1980`. És un "truc" aritmètic molt utilitzat per arrodonir cap avall a la desena, centena, etc.
- `estiu$decada <- ...`: com ja hem fet diverses vegades, afegim aquest resultat com una columna nova a la taula `estiu` (la que ja teníem filtrada per mesos d'estiu, de l'Activitat 2).

*(Nota: si `ANY` fos negatiu això no funcionaria igual, però per a anys de calendari
com els nostres no hi ha cap problema.)*

## Pas 2 — Resumir per grups amb `aggregate()`

Fins ara, per canviar de subconjunt de dades (un any, un període...) havíem de
tornar a escriure `subset()` cada vegada. La funció `aggregate()` fa una cosa més
potent: **calcula un resum per a cada grup, tot d'una vegada**.

```r
aggregate(tropical ~ decada, data = estiu, FUN = sum)
```

**Explicació pas a pas (aquesta línia té una sintaxi nova, val la pena aturar-s'hi):**

- `tropical ~ decada`: això és una **fórmula** de R (el símbol `~` es llegeix "en funció de" o "explicat per"). Es llegeix: "vull un resum de `tropical`, agrupat segons `decada`". És la mateixa notació `~` que farem servir més endavant amb la recta de regressió.
- `data = estiu`: li diem a R en quina taula ha de buscar les columnes `tropical` i `decada`.
- `FUN = sum`: la funció que s'ha d'aplicar dins de cada grup. Aquí volem la **suma** dels `TRUE` (recorda el mini manual de l'Activitat 1: sumar un vector de `TRUE`/`FALSE` compta els `TRUE`). Si volguéssim la mitjana en comptes de la suma, escriuríem `FUN = mean`.
- El resultat és una taula petita, amb una fila per dècada i dues columnes: `decada` i el resum (`tropical`, ara ja reanomenat implícitament com la suma).

Amb la mateixa idea, podem obtenir també el nombre total de nits d'estiu
registrades a cada dècada (per calcular després el percentatge):

```r
aggregate(tropical ~ decada, data = estiu, FUN = length)
```

**Explicació:** `length()` no suma els `TRUE`, sinó que compta **quantes files** hi
ha a cada grup (tant si són `TRUE` com `FALSE`). Necessitem aquest número perquè,
com veurem a la taula final, **no totes les dècades tenen el mateix nombre d'anys**:
1950–2019 en tenen 10 cadascuna, però 2020–2025 només en té 6 (encara no ha
acabat!). Per això, per poder comparar dècades de manera justa, cal fer servir el
**percentatge** i no el nombre absolut de nits tropicals.

!!! note "Mini manual R: combinant els dos resultats"

    Per tenir-ho tot junt en una sola taula, podem fer:

    ```r
    total_dec <- aggregate(tropical ~ decada, data = estiu, FUN = length)
    trop_dec  <- aggregate(tropical ~ decada, data = estiu, FUN = sum)

    resum <- data.frame(
      decada = total_dec$decada,
      n_total = total_dec$tropical,
      n_tropicals = trop_dec$tropical
    )
    resum$percentatge <- round(100 * resum$n_tropicals / resum$n_total, 2)
    resum
    ```

    - `data.frame(...)`: la funció que crea una taula de dades des de zero, indicant
      columna per columna. Aquí en construïm una de nova (`resum`) combinant els
      resultats dels dos `aggregate()` anteriors.
    - `resum$percentatge <- round(100 * resum$n_tropicals / resum$n_total, 2)`:
      calculem el percentatge (n_tropicals dividit pel total, multiplicat per 100) i
      l'arrodonim a 2 decimals amb `round(valor, decimals)`.

## Pas 3 — A Google Sheets: taula dinàmica (*pivot table*)

Fins ara, a Sheets hem fet servir fórmules soltes (`COMPTA.SI`, `SI`, `FREQÜÈNCIA`,
`FILTRA`). Per a un resum "agrupa per dècada i calcula", Sheets té una eina feta
expressament per a això: la **taula dinàmica**.

1. Amb les dades d'estiu (i les columnes `tropical` i `decada` ja calculades com a l'Activitat 1 i el Pas 1 d'aquí), selecciona tot el rang i vés a **Inserir → Taula dinàmica**.
2. A la finestra de configuració:
    - **Files**: arrossega-hi el camp `decada`.
    - **Valors**: arrossega-hi el camp `tropical` **dues vegades**: un cop configurat com **RECOMPTE** (per obtenir el total de nits registrades a la dècada) i un altre cop configurat com **SUMA** (si `tropical` és una columna de VERTADER/FALS —o d'1/0—, sumar-la dona directament el nombre de nits tropicals).
3. Afegeix una columna de fórmula al costat per calcular el percentatge (SUMA dividit per RECOMPTE, multiplicat per 100).

La taula dinàmica actualitza automàticament els resultats si canvien les dades
d'origen, sense que hagis de tornar a escriure cap fórmula: aquesta és la seva gran
avantatge respecte a construir-ho tot amb `COMPTA.SI` fila a fila.

## La taula completa: nits tropicals per dècada (estiu, 1950–2025)

| Dècada | Anys inclosos | n total de nits d'estiu | $n_i$ (nits tropicals) | $f_i$ (%) |
|---|---|---|---|---|
| 1950 | 1950–1959 (10 anys) | 1.220 | 99 | 8,11% |
| 1960 | 1960–1969 (10 anys) | 1.220 | 76 | 6,23% |
| 1970 | 1970–1979 (10 anys) | 1.220 | 32 | 2,62% |
| 1980 | 1980–1989 (10 anys) | 1.220 | 78 | 6,39% |
| 1990 | 1990–1999 (10 anys) | 1.220 | 131 | 10,74% |
| 2000 | 2000–2009 (10 anys) | 1.220 | 184 | 15,08% |
| 2010 | 2010–2019 (10 anys) | 1.220 | 221 | 18,11% |
| 2020 | 2020–2025 (**només 6 anys**) | 732 | 206 | 28,14% |

**Interpretació:** el percentatge de nits tropicals a l'estiu passa d'un 8,11% a la
dècada de 1950 a un 28,14% en el que portem de la dècada de 2020: **més del
triple**. La tendència no és perfectament monòtona (fixa't que la dècada de 1970 té
el valor més baix de tota la sèrie, per sota fins i tot de la de 1960), però la
direcció general, especialment a partir de 1990, és clarament ascendent.

**Advertència metodològica important:** la dècada de 2020 només té 6 anys
(2020–2025) enfront dels 10 de la resta. Justament per això hem calculat sempre el
**percentatge** ($f_i$) i no el nombre absolut: comparar 206 nits (6 anys) amb 221
nits (10 anys) seria enganyós, però comparar 28,14% amb 18,11% sí que és una
comparació justa. Aquest és un exemple real de per què, en estadística, gairebé
sempre és més honest treballar amb freqüències relatives que amb absolutes quan els
grups no tenen la mateixa mida.

## Per practicar

a) Amb `aggregate()`, calcula la temperatura mínima **mitjana** (`FUN = mean`) de cada dècada (sobre les dades d'estiu). La tendència que observes és coherent amb la taula de percentatges de nits tropicals?

b) A Sheets, amplia la taula dinàmica afegint també el càlcul de la temperatura mitjana per dècada.

c) Per què creus que NO té sentit calcular la freqüència absoluta **acumulada** ($N_i$) en aquesta taula (dècada rere dècada)? *Pista: pensa en què representaria "acumular" nits tropicals d'una dècada a la següent.*

## Resum de l'activitat

- Hem calculat una nova variable, la **dècada**, amb l'operador de divisió entera `%/%`.
- Hem après `aggregate()`, que calcula un resum (suma, mitjana, recompte...) **per grups**, amb la notació `variable ~ grup`.
- Hem construït la taula de freqüències final del projecte: percentatge de nits tropicals per dècada, de 1950 a 2025.
- Hem après per què cal comparar amb **percentatges** i no amb valors absoluts quan els grups (aquí, les dècades) no tenen la mateixa mida.
- A Sheets, hem introduït la **taula dinàmica** com a eina natural per a aquest tipus de resum agrupat.

**Següent pas (Activitat 5):** representarem aquesta taula amb el nostre primer
gràfic (un diagrama de barres), tancant el cicle "dades → taula → gràfic" amb què
hem començat el curs.
