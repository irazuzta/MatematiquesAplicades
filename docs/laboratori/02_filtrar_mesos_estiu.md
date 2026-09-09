# Activitat 2 — Filtrar: quedem-nos només amb l'estiu

*Laboratori · Relacionat amb [Bloc 1 — Taules de freqüència](../presentacions/01_taules_frequencia.md)*

[:material-file-pdf-box: Descarrega l'activitat (PDF)](../assets/laboratori/Activitat2_Filtrar_Mesos_Estiu.pdf){ .md-button }

## Context

Seguim treballant amb el registre diari de Nulles/Valls (1950–2025) i amb la nostra
variable "nit tropical" (TN ≥ 20 ºC), creada a l'Activitat 1. Allà vam detectar un
problema: si calculem el percentatge de nits tropicals sobre **l'any sencer**, el
resultat queda "diluït" perquè inclou mesos (desembre, gener...) on el fenomen és
pràcticament impossible a casa nostra.

La solució és **filtrar**: quedar-nos únicament amb les files que ens interessen, en
aquest cas els mesos d'estiu. En aquest projecte definim **estiu** com els mesos de
**juny a setembre (mesos 6, 7, 8 i 9)**. Pot semblar una definició una mica més
àmplia que l'estiu "oficial" (que a l'hemisferi nord comença el 21 de juny), però
inclou el juny sencer perquè és quan comencen a aparèixer les primeres nits
tropicals amb regularitat, i deixem fora l'octubre perquè les nits ja solen
refrescar-se prou.

**Filtrar** és una de les operacions més bàsiques —i més utilitzades— en qualsevol
anàlisi de dades: gairebé sempre, abans de calcular res, cal decidir *amb quin
subconjunt de les dades* farem els càlculs.

## Objectius

- Entendre què significa **filtrar** una taula de dades i per què sovint és un pas necessari abans de calcular freqüències, mitjanes, etc.
- Aprendre a filtrar per **múltiples valors possibles** d'una columna (mes 6, 7, 8 o 9), tant a R (`%in%`) com a Sheets (`FILTRA` amb `+`).
- Reconstruir la taula de freqüències de "nit tropical" (Activitat 1) però ara **només amb dades d'estiu**, i comparar el resultat.

## Pas 1 — Filtrar per múltiples mesos a R

A l'Activitat 1 vam fer servir `subset()` amb una única condició (`ANY == 2020`). Ara
necessitem una condició una mica més rica: "el mes és 6, **o** 7, **o** 8, **o** 9".
Podríem escriure-ho amb l'operador "o" (`|`), però R ofereix una eina més còmoda per
a aquest cas: l'operador `%in%`.

```r
estiu <- subset(dades, MES %in% c(6, 7, 8, 9))
nrow(estiu)
```

**Explicació pas a pas:**

- `c(6, 7, 8, 9)`: la funció `c()` (de *combine*, "combinar") crea un **vector**, és a dir, una llista de valors. `c(6, 7, 8, 9)` és el vector amb els quatre mesos d'estiu.
- `MES %in% c(6, 7, 8, 9)`: l'operador `%in%` es llegeix "pertany a". Per a cada fila, pregunta "el valor de `MES` d'aquesta fila, és un dels valors de la llista?" i retorna `TRUE` o `FALSE`. És equivalent a escriure `MES == 6 | MES == 7 | MES == 8 | MES == 9`, però molt més curt i llegible.
- `subset(dades, ...)`: com ja sabem, ens quedem només amb les files on la condició és `TRUE`.
- `estiu <-`: guardem el resultat amb un nom nou. A partir d'ara, `estiu` conté només els dies de juny, juliol, agost i setembre, de tots els anys (1950–2025).

Si tot ha anat bé, `nrow(estiu)` t'hauria de donar **9.272** files (76 anys complets × 122 dies d'estiu cadascun, aproximadament).

!!! note "Mini manual R: per què no fem servir `==` amb una llista?"

    Un error molt habitual quan es comença amb R és escriure `MES == c(6,7,8,9)`
    esperant que funcioni com `%in%`. No ho fa: `==` compara **element a element**,
    no "pertany a la llista", i dona resultats incorrectes o avisos d'error
    estranys. Sempre que vulguis comprovar si un valor és un d'entre diversos
    possibles, fes servir `%in%`.

## Pas 2 — Refer la variable "nit tropical" sobre les dades d'estiu

```r
estiu$tropical <- estiu$TN >= 20
table(estiu$tropical)
prop.table(table(estiu$tropical))
```

Aquestes línies són exactament les mateixes que a l'Activitat 1, però ara aplicades
a `estiu` en lloc de `any2020`: la lògica no canvia, només canvia **el conjunt de
dades de partida**. Aquesta és una idea important en programació: un cop tens un
procediment que funciona, el pots reaplicar a dades diferents sense reescriure'l des
de zero.

## Pas 3 — Filtrar per múltiples valors a Google Sheets: `FILTRA`

A Sheets, la funció equivalent a `subset()` és `FILTRA`. Per quedar-nos amb els
mesos d'estiu (columna `B` = `MES`):

```
=FILTRA(A2:F27760; (B2:B27760=6) + (B2:B27760=7) + (B2:B27760=8) + (B2:B27760=9))
```

**Explicació:**

- `FILTRA(rang; condició)`: retorna només les files del `rang` on la `condició` és certa (diferent de zero).
- `A2:F27760`: el rang de dades que volem filtrar (ajusta el número de fila final al nombre real de files del teu full).
- `(B2:B27760=6) + (B2:B27760=7) + (B2:B27760=8) + (B2:B27760=9)`: aquí fem el mateix "truc" `TRUE`=1/`FALSE`=0 que hem vist a R, però en Sheets: cada comparació `(B2:B27760=6)` dona una columna de `VERTADER`/`FALS` (que Sheets tracta com 1/0), i **sumant-les** amb `+` obtenim un valor diferent de zero (és a dir, "cert" per a `FILTRA`) si el mes és el 6, el 7, el 8 **o** el 9. Si sumàvem `AND`/`I` en comptes de `+`, exigiríem que es complissin totes alhora, cosa que mai passaria (un mes no pot ser 6 i 7 a la vegada).

Aquesta fórmula genera automàticament una taula nova amb només les files d'estiu,
sense haver de tocar res manualment (a diferència del filtre manual que vam fer
servir a l'Activitat 1). Un cop tens aquestes dades filtrades en un rang nou, pots
aplicar-hi la mateixa fórmula `SI` i `COMPTA.SI` de l'Activitat 1 per reconstruir la
taula de nit tropical.

## Comparem els resultats: any sencer vs. només estiu

Amb les dades **d'estiu de tota la sèrie (1950–2025)**, la taula de freqüències de
"nit tropical" (n = 9.272 nits d'estiu) queda:

| Nit tropical? (només estiu) | $n_i$ | $f_i$ | $f_i$ (%) |
|---|---|---|---|
| No | 8.245 | 0,889 | 88,9% |
| Sí | 1.027 | 0,111 | 11,1% |
| **Total** | **9.272** | **1,00** | **100%** |

**Interpretació:** un 11,1% de les nits d'estiu (juny–setembre) de tota la sèrie
1950–2025 han estat tropicals. Compara aquest valor amb el 5,7% que havíem obtingut
a l'Activitat 1 fent servir l'any 2020 sencer (hivern inclòs): el percentatge puja
perquè ara el denominador (el "total") ja no inclou dies on el fenomen és
impossible. Aquest és exactament l'efecte que sospitàvem: **filtrar abans de
calcular canvia el resultat**, i normalment el fa més representatiu del que volem
estudiar de debò.

## Per practicar

a) Calcula (amb R o Sheets) el percentatge de nits tropicals només per al mes de **juliol** de tota la sèrie. És més alt o més baix que l'11,1% del conjunt juny–setembre? Per què creus que passa això?

b) A R, `estiu$MES` només pot valer 6, 7, 8 o 9 (ja hem filtrat). Comprova-ho amb `table(estiu$MES)`: hauries d'obtenir quatre categories, una per mes.

c) Reflexiona: si volguéssim estudiar les **glaçades** (nits amb TN ≤ 0 ºC) en lloc de les nits tropicals, per quins mesos hauria de filtrar les dades? Escriu la instrucció de R (`%in%`) que ho faria.

## Resum de l'activitat

- Hem après a **filtrar** una taula de dades per quedar-nos només amb un subconjunt (els mesos d'estiu), amb `%in%` a R i `FILTRA` a Sheets.
- Hem vist que triar bé el conjunt de dades sobre el qual calculem (filtrar abans de calcular) és tan important com el càlcul en si mateix.
- Hem reconstruït la taula de freqüències de "nit tropical" amb dades ja filtrades, i n'hem comparat el resultat amb el de l'Activitat 1.

**Següent pas (Activitat 3):** la temperatura mínima (`TN`) és una variable
contínua; en lloc de reduir-la a Sí/No, aprendrem a construir-ne una taula de
freqüències **amb intervals**, tal com vam veure al Bloc 1 amb l'exemple de les
alçades.
