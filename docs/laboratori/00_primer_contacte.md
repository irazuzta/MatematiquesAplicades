# Activitat 0 — Primer contacte amb les dades i amb R

*Laboratori · Relacionat amb [Bloc 1 — Taules de freqüència](../presentacions/01_taules_frequencia.md)*

[:material-file-pdf-box: Descarrega l'activitat (PDF)](../assets/laboratori/Activitat0_Primer_Contacte.pdf){ .md-button }

## Les nits tropicals, ara i abans

Al llarg d'aquest bloc (i dels següents) treballarem sempre amb el mateix conjunt de
dades reals, perquè així podrem anar aplicant cada concepte nou (taules de
freqüències, gràfics, mitjana, desviació típica, regressió...) sobre un mateix
"repte": **saber si les nits d'estiu són cada cop més caloroses a casa nostra**.

Les dades provenen del **Servei Meteorològic de Catalunya (Meteocat)**, de l'estació
climàtica de **Nulles/Valls** (comarca de l'Alt Camp), i contenen el registre
**diari** de tres variables des de l'1 de gener de 1950 fins avui:

| Variable | Nom a l'arxiu | Unitats | Significat |
|---|---|---|---|
| Precipitació acumulada diària | `PPT` | mm | Quanta pluja ha caigut aquell dia |
| Temperatura màxima diària | `TX` | ºC | La temperatura més alta que s'ha registrat aquell dia |
| Temperatura mínima diària | `TN` | ºC | La temperatura més baixa que s'ha registrat aquell dia (normalment de matinada) |

A més, cada fila té tres columnes que identifiquen **quan** s'ha pres la dada: `ANY`,
`MES` i `DIA`.

**Per què ens interessa la `TN` (temperatura mínima)?** Perquè és la que fem servir
per definir una **nit tropical**: una nit en què la temperatura no baixa de 20 ºC.
Passar la nit per sobre de 20 ºC dificulta el descans i té efectes reals sobre la
salut, per això els serveis meteorològics en porten el compte. Durant el curs
construirem, pas a pas, les eines estadístiques necessàries per estudiar com ha
evolucionat aquest fenomen a Nulles al llarg de més de 70 anys.

!!! note "Nota important"

    Hi ha un concepte encara més extrem, la **nit tòrrida** (TN ≥ 25 ºC). A Nulles,
    en tota la sèrie 1950–2025, **no s'ha donat mai** cap nit tòrrida (la TN més alta
    registrada a l'estiu és de 24,5 ºC). Per això, en tot el material treballarem amb
    el llindar de **nit tropical (20 ºC)**, que sí que és un fenomen que podem
    observar i mesurar en aquesta estació.

El fitxer de dades complet ([`nulles_dades_climatiques_diaries.txt`](../assets/dades/nulles_dades_climatiques_diaries.txt),
27.759 dies) es pot descarregar per treballar-hi en local.

## Objectius d'aquesta activitat

En aquesta primera activitat **no calcularem res encara**: l'objectiu és només
**familiaritzar-nos amb les dades i amb les dues eines** que farem servir tot el
curs (Google Sheets i RStudio), de manera que a partir de l'Activitat 1 ja puguem
centrar-nos en l'estadística.

En acabar aquesta activitat hauràs de ser capaç de:

- Importar l'arxiu de dades a Google Sheets i a R sense errors.
- Explicar què representa cada columna del fitxer i de quin tipus de variable es tracta (segons el Bloc 1: qualitativa/quantitativa, discreta/contínua).
- Fer servir les primeres ordres de R per mirar les dades: `read.table()`, `head()`, `View()`, `nrow()`, `ncol()`, `str()`.
- Calcular estadístics bàsics d'una columna: `max()`, `min()`, `mean()`, `median()`, `summary()`.
- Crear el teu propi conjunt de dades des de la consola, amb `c()`, i explorar-lo (`length()`, `sort()`...).
- Extreure una columna concreta d'una taula de dades en R amb el símbol `$`.

## L'arxiu de dades

El fitxer es diu `nulles_dades_climatiques_diaries.txt`. És un arxiu de text amb una
peculiaritat important: **les 11 primeres línies no són dades**, sinó una capçalera
informativa sobre l'estació:

```
SERVEI METEOROLÒGIC DE CATALUNYA
Nom de la sèrie: NULLES/VALLS
Comarca: ALT CAMP
Codi sèrie: baic0022d
Variable1: PRECIPITACIÓ ACUMULADA DIÀRIA (PPT, en mm)
Variable2: TEMPERATURA MÀXIMA DIÀRIA (TX, en ºC)
Variable3: TEMPERATURA MÍNIMA DIÀRIA (TN, en ºC)
X UTM31: 354383 m
Y UTM31: 4572742 m
Z UTM31: 230 m

ANY	MES	DIA	PPT	TX	TN
1950	1	1	0	12.1	5.6
1950	1	2	0	10.6	2.1
...
```

La línia 12 (`ANY  MES  DIA  PPT  TX  TN`) és la **capçalera de la taula** (el nom de
cada columna), i a partir de la línia 13 comencen les dades pròpiament dites, una
fila per dia. Les columnes estan separades per **tabulacions** (la tecla de
tabulador, no espais ni comes), per això diem que és un arxiu **TSV**
(*tab-separated values*), cosí germà del més conegut CSV (*comma-separated values*,
separat per comes).

Aquest detall —que les primeres 11 línies no són dades— és el primer que haurem de
dir tant a Google Sheets com a R quan els demanem que llegeixin l'arxiu, o la
importació sortirà malament.

## Pas 1 — Obrir l'arxiu a Google Sheets

1. Crea un full de càlcul nou a Google Sheets.
2. Menú **Arxiu → Importa → Puja** i selecciona `nulles_dades_climatiques_diaries.txt`.
3. Google Sheets et preguntarà com vols importar-lo. Tria:
   - **Ubicació d'importació:** *Reemplaça el full actual* (o *Insereix un full nou*, com prefereixis).
   - **Tipus de separador:** normalment Sheets detecta automàticament que és una **tabulació**; si no ho fa, selecciona-ho manualment.
4. Un cop importat, veuràs que les **11 primeres files** contenen el text informatiu de la capçalera i que la fila 12 té els noms de columna (`ANY`, `MES`, `DIA`, `PPT`, `TX`, `TN`). Selecciona les files 1 a 11 (clicant als números de fila) i **elimina-les** (botó dret → *Suprimeix les files*), de manera que la fila 1 del full passi a ser `ANY MES DIA PPT TX TN` i la fila 2 sigui la primera dada (1950, 1, 1...).
5. Congela la primera fila (**Visualització → Congela → 1 fila**) perquè es vegin sempre els noms de columna encara que et desplacis avall.

Al final hauries de tenir un full net, amb capçalera a la fila 1 i dades a partir de
la fila 2, amb tantes files com dies té la sèrie (27.759 dies, més de 75 anys de
dades!).

## Pas 2 — Primer contacte amb RStudio

Segons com estigui configurat l'ordinador on treballis, en obrir RStudio pots
trobar-te vistes lleugerament diferents. Hi ha, però, **tres finestres que sempre hi
seran**:

| Finestra | Per a què serveix |
|---|---|
| **Console** (consola) | On escrius ordres i R et respon a l'instant. És com una calculadora molt potent. |
| **Environment** (entorn) | La llista de "coses" (dades, resultats...) que tens guardades en aquell moment. |
| **Files / Plots / Help** | Explorador d'arxius, gràfics que generis, i ajuda de les funcions. |

A més d'aquestes tres, **pot ser que en vegis una quarta**, situada a la part
superior esquerra, per sobre de la consola. És la finestra de l'editor (anomenada
*Source*), i hi apareix quan hi ha algun arxiu `.R` obert (un script) o quan algú ha
fet servir `View()` per mirar una taula de dades. Si el teu ordinador ja l'havia fet
servir abans, és possible que la quarta finestra ja hi sigui des del primer moment,
amb contingut d'una sessió prèvia.

**Si no la veus** (només tens les tres finestres de la taula anterior), és perquè
encara no hi ha cap script obert: és una situació igual de normal, i es soluciona en
un pas.

## Pas 3 — Obrir un script i escriure les primeres ordres

Per fer aparèixer la finestra de l'editor (o per obrir-ne una de nova i començar
net):

1. Vés al menú **File → New File → R Script** (o la drecera **Ctrl+Maj+N**).
2. Automàticament apareixerà una quarta finestra a la part superior esquerra, per sobre de la consola: aquest és l'editor de script (*Source*).
3. Desa'l amb **Ctrl+S**, posa-li un nom (per exemple, `activitat0.R`) i tria la carpeta on tens l'arxiu de dades.

A partir d'ara ja tindràs les quatre finestres de la taula següent:

| Finestra | Per a què serveix |
|---|---|
| **Source** (editor de script) | On escrius i desa el codi en un arxiu `.R`, per poder-lo tornar a executar més endavant. |
| **Console** (consola) | On escrius ordres i R et respon a l'instant. És com una calculadora molt potent. |
| **Environment** (entorn) | La llista de "coses" (dades, resultats...) que tens guardades en aquell moment. |
| **Files / Plots / Help** | Explorador d'arxius, gràfics que generis, i ajuda de les funcions. |

Recomanem que **no treballis directament a la consola**, sinó que escriguis les
ordres al script que acabes d'obrir, perquè així les tens guardades i les pots tornar
a executar sense retornar-les a escriure. Per executar una línia del script, la
selecciones (o hi poses el cursor) i prems **Ctrl+Enter** (o el botó "Run"): la
instrucció s'envia a la consola, que és qui realment l'executa i mostra el resultat.

## Pas 4 — Conceptes bàsics de R abans de començar

- **Funció**: una ordre que fa alguna cosa, amb la forma `nom_funcio(arguments)`. Per exemple, `nrow(dades)` és la funció `nrow` aplicada a l'argument `dades`.
- **Assignació (`<-`)**: a R, per desar un resultat amb un nom, fem servir la fletxa `<-` (i no el símbol `=`, encara que també funcioni). Per exemple: `dades <- read.table(...)` vol dir "el resultat de llegir l'arxiu, desa'l amb el nom `dades`".
- **Objecte**: qualsevol cosa que tingui un nom desat a R (una taula de dades, un número, una llista de valors...). Un cop creat, apareix a la finestra *Environment*.
- **Comentari (`#`)**: tot el que escrius després d'un coixinet `#` en una línia, R l'ignora. Serveix per anotar-nos què fa el codi.

## Pas 5 — Llegir l'arxiu amb R

Escriu al teu script:

```r
# Llegim l'arxiu de dades de Nulles.
# skip = 11 -> ens saltem les 11 primeres línies (la capçalera informativa)
# header = TRUE -> la primera línia que SÍ llegim conté els noms de columna
# sep = "\t" -> les columnes estan separades per tabulacions
dades <- read.table("nulles_dades_climatiques_diaries.txt",
                     skip = 11, header = TRUE, sep = "\t")
```

**Explicació de cada part de la instrucció:**

- `read.table(...)`: la funció de R que llegeix un arxiu de text i el converteix en una taula de dades (el que R anomena un *data frame*).
- `"nulles_dades_climatiques_diaries.txt"`: el primer argument, entre cometes perquè és un **text** (el nom de l'arxiu). Ha d'estar a la mateixa carpeta que el teu script, o bé has d'indicar el camí complet.
- `skip = 11`: li diem a R que ignori les 11 primeres línies del fitxer (la capçalera informativa que hem vist abans).
- `header = TRUE`: li diem que, un cop saltades aquestes 11 línies, la **primera línia que trobi** (`ANY MES DIA PPT TX TN`) s'ha d'interpretar com els noms de les columnes, no com a dades.
- `sep = "\t"`: li indiquem que el caràcter que separa les columnes és una tabulació (s'escriu `"\t"` a R).
- `dades <-`: guardem el resultat amb el nom `dades`. A partir d'ara, `dades` és la nostra taula sencera, amb totes les files i columnes.

## Pas 6 — Explorar la taula

Un cop llegida, mai treballem "a cegues": sempre val la pena mirar què hem carregat
abans de continuar.

```r
head(dades)      # mostra les 6 primeres files
View(dades)      # obre la taula en una finestra, com un full de càlcul
nrow(dades)      # quantes files (dies) té la taula
ncol(dades)      # quantes columnes té la taula
str(dades)       # resumeix l'estructura: tipus de cada columna
```

**Què fa cada funció:**

| Funció | Què retorna | Per què és útil |
|---|---|---|
| `head(dades)` | Les primeres 6 files de la taula | Comprovar ràpidament que la lectura ha anat bé (noms de columna correctes, valors amb sentit) |
| `View(dades)` | Obre una pestanya nova amb la taula sencera, navegable | Inspeccionar visualment, com si fos un full de càlcul (però només per mirar, no per editar) |
| `nrow(dades)` | Un número: el nombre de files | Saber la mida de la mostra (aquí: el nombre de dies registrats) |
| `ncol(dades)` | Un número: el nombre de columnes | Saber quantes variables tenim |
| `str(dades)` | Un resum tècnic de cada columna (nom i tipus: `int`, `num`...) | Detectar si alguna columna s'ha llegit malament (per exemple, com a text en lloc de número) |

Si tot ha anat bé, `nrow(dades)` t'hauria de donar **27.759** (un per cada dia entre
l'1 de gener de 1950 i el 31 de desembre de 2025), i `ncol(dades)` hauria de donar
**6**.

## Pas 7 — Estadístics bàsics d'una columna

Per acabar de familiaritzar-te amb R, prova aquestes funcions sobre la columna `TN`
(temperatura mínima):

```r
max(dades$TN)       # el valor més alt de tota la columna
min(dades$TN)       # el valor més baix de tota la columna
mean(dades$TN)      # la mitjana de tots els valors
median(dades$TN)    # la mediana (el valor central, si els ordenem)
summary(dades$TN)   # un resum de "cop d'ull": mínim, quartils, mitjana i màxim
```

**Explicació:**

| Funció | Què retorna |
|---|---|
| `max(vector)` | El valor més gran del vector |
| `min(vector)` | El valor més petit del vector |
| `mean(vector)` | La mitjana aritmètica |
| `median(vector)` | La mediana (el valor que quedaria al mig si ordenéssim totes les dades) |
| `summary(vector)` | Un resum automàtic amb sis valors: mínim, primer quartil, mediana, mitjana, tercer quartil i màxim |

Fixa't que `max()`, `min()`, `mean()`... segueixen tots el mateix patró:
`nom_funcio(vector)`. Un cop coneixes aquest patró, aprendre una funció nova de R
normalment és tan senzill com saber quin nom té.

*(Aquestes mesures —mitjana, mediana, quartils...— encara no les hem estudiat
formalment: en parlarem als Blocs 3, 4 i 5. Aquí les fem servir només per practicar
la sintaxi de R amb funcions senzilles.)*

!!! warning "Compte amb els valors que falten (`NA`)"

    Si alguna d'aquestes funcions et retorna `NA` en lloc d'un número, vol dir que la
    columna té algun valor mancant (per exemple, un dia sense registre). En aquest
    cas, moltes funcions de R (`mean()`, `max()`, `min()`...) accepten l'argument
    `na.rm = TRUE` ("*NA remove*", elimina els `NA`) perquè ignorin aquests forats i
    calculin igualment: `mean(dades$TN, na.rm = TRUE)`.

## Pas 8 — Crear el teu propi conjunt de dades des de la consola

Fins ara sempre hem partit d'un arxiu extern (`read.table()`). Però sovint, sobretot
quan estem aprenent o fent una prova ràpida, és útil poder crear un petit conjunt de
dades **directament a R**, sense cap arxiu, escrivint els valors a mà.

Per fer-ho, fem servir la funció `c()` (de *combine*, "combinar"), que agafa diversos
valors solts i els combina en un únic **vector**.

```r
notes <- c(5, 7, 8, 3, 9, 6, 10, 4)
notes
```

**Explicació:**

- `c(5, 7, 8, 3, 9, 6, 10, 4)`: crea un vector amb aquests 8 números, en aquest ordre.
- `notes <-`: el guardem amb el nom `notes`. Ara `notes` és un objecte nou, tan "real" com `dades`, encara que no vingui de cap arxiu.
- Si escrius només `notes` i executes, R te'l mostra sencer a la consola.

Un cop tens el teu propi vector, li pots aplicar exactament les mateixes funcions que
acabem de veure:

```r
length(notes)   # quants valors té el vector (aquí: 8)
mean(notes)     # la mitjana
max(notes)      # el valor més alt
min(notes)      # el valor més baix
sort(notes)     # els mateixos valors, però ordenats de menor a major
```

**Explicació:**

- `length(vector)`: una funció nova que compta **quants elements** té un vector (l'equivalent de `nrow()`, però per a un vector en lloc d'una taula sencera).
- `sort(vector)`: retorna el mateix vector amb els valors reordenats (de menor a major per defecte). Per ordenar-los de major a menor: `sort(notes, decreasing = TRUE)`.

Aquesta manera de crear dades "a mà" et servirà molt durant el curs: per exemple, per
provar ràpidament una fórmula o una funció nova amb un conjunt de números petit i
controlat, abans d'aplicar-la a les 27.759 files del conjunt de Nulles.

## Pas 9 — Vector vs. data frame

És important no confondre els dos tipus d'objecte que ja coneixem:

- Un **vector** (com `notes`, o com `dades$TN`) és una única columna de valors, tots del mateix tipus (tots números, o tots text...).
- Un **data frame** (com `dades`) és una taula sencera, amb diverses columnes (que poden ser de tipus diferents: `ANY` és un número enter, per exemple) i un nom per a cadascuna.

De fet, cada columna d'un data frame (`dades$TN`, `dades$ANY`...) **és** un vector:
per això les mateixes funcions (`mean()`, `max()`, `length()`...) funcionen igual
tant si les apliques a `notes` com a `dades$TN`.

## Pas 10 — Accedir a una columna concreta: el símbol `$`

Sovint no volem tota la taula, sinó només **una columna**. A R, s'hi accedeix amb el
símbol `$`:

```r
dades$TN          # tota la columna de temperatures mínimes
dades$TN[1:10]    # només els 10 primers valors d'aquesta columna
mean(dades$TN)    # la mitjana de TOTES les temperatures mínimes (hivern inclòs!)
```

**Explicació:**

- `dades$TN`: agafa la columna `TN` de la taula `dades`. El resultat és una llista de números (a R en diem *vector*), un per cada fila de la taula.
- `dades$TN[1:10]`: els claudàtors `[...]` serveixen per seleccionar posicions concretes dins d'un vector; `1:10` vol dir "de l'1 al 10". Així doncs, obtenim només els 10 primers valors.
- `mean(dades$TN)`: la funció `mean()` calcula la mitjana d'un vector de números. Ull: aquí estem fent la mitjana de **totes** les temperatures mínimes de l'any sencer (gener inclòs!), cosa que barreja hivern i estiu. Més endavant (Activitat 2) aprendrem a quedar-nos només amb els mesos d'estiu abans de calcular res.

## Pas 11 — I a Google Sheets?

L'equivalent de "mirar les primeres files" a Sheets és tan senzill com desplaçar-te a
dalt del full. Per obtenir el nombre de files de dades (equivalent a `nrow()`), pots
fer servir la fórmula:

```
=CONTAR(A2:A)
```

**Explicació:** `CONTAR()` compta quantes cel·les d'un rang contenen un **número**.
El rang `A2:A` vol dir "de la cel·la A2 fins al final de la columna A" (suposant que
la columna A és `ANY`, i que la fila 1 és la capçalera). El resultat t'hauria de
coincidir amb el `nrow(dades)` que has obtingut a R.

## Classifica les variables (repàs del Bloc 1)

Abans d'acabar, repassem els [tipus de variable](../presentacions/01_taules_frequencia.md)
aplicats a aquest mateix conjunt de dades. Completa la taula:

| Variable | Tipus (qualitativa/quantitativa, nominal/ordinal/discreta/contínua) |
|---|---|
| `ANY` (any) | |
| `MES` (mes, 1–12) | |
| `DIA` (dia del mes) | |
| `PPT` (precipitació, mm) | |
| `TX` (temperatura màxima, ºC) | |
| `TN` (temperatura mínima, ºC) | |

*Pista:* pensa si cada variable resulta de **comptar** (valors aïllats, no té sentit
un valor intermedi) o de **mesurar** (en teoria, qualsevol valor decimal és possible
dins un interval).

## Resum de l'activitat

- Hem importat el mateix conjunt de dades (temperatures i pluviometria diàries de Nulles, 1950–2025) tant a Google Sheets com a R, tenint cura de saltar-nos les 11 línies de capçalera informativa.
- Hem après les primeres funcions de R per explorar una taula de dades: `read.table()`, `head()`, `View()`, `nrow()`, `ncol()`, `str()`.
- Hem calculat estadístics bàsics d'una columna (`max()`, `min()`, `mean()`, `median()`, `summary()`) i hem après a gestionar valors mancants amb `na.rm = TRUE`.
- Hem creat el nostre propi conjunt de dades des de zero amb `c()`, i l'hem explorat amb `length()` i `sort()`, distingint entre un **vector** i un **data frame**.
- Hem après a extreure una columna concreta amb `$` i a seleccionar-ne una part amb `[...]`.
- Hem repassat la classificació de variables del Bloc 1 aplicant-la a un cas real.

**Següent pas (Activitat 1):** definirem la nostra primera variable pròpia —si una
nit és tropical o no— i construirem la nostra primera taula de freqüències amb dades
reals.
