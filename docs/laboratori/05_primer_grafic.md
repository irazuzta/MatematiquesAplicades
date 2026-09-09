# Activitat 5 — El primer gràfic: diagrama de barres per dècada

*Laboratori · Relacionat amb [Bloc 1 — Taules de freqüència](../teoria/01_taules_frequencia.md)*

[:material-file-pdf-box: Descarrega l'activitat (PDF)](../assets/laboratori/Activitat5_Primer_Grafic.pdf){ .md-button }

## Context

Hem arribat al final del recorregut d'aquest bloc: a l'Activitat 4 vam obtenir la
taula que resumeix tot el projecte —el percentatge de nits tropicals a Nulles,
dècada rere dècada, de 1950 a 2025—. Ara falta l'últim pas, el que dona sentit
visual a tota la feina anterior: **representar aquesta taula amb un gràfic**.

Recorda la taula del Bloc 1 sobre quin gràfic correspon a cada tipus de variable:

| Tipus de variable | Gràfic recomanat |
|---|---|
| Qualitativa nominal | Diagrama de sectors (o de barres) |
| Qualitativa ordinal | Diagrama de barres |
| Quantitativa discreta | Diagrama de barres |
| Quantitativa contínua (agrupada) | Histograma |

La **dècada** és, en aquest cas, una variable que tractem com si fos discreta i
ordenada (1950, 1960, 1970...): per tant, el gràfic que li correspon és un
**diagrama de barres**, amb una barra per dècada i una alçada proporcional al
percentatge de nits tropicals.

## Objectius

- Construir un diagrama de barres a R amb la funció `barplot()`, a partir de la taula resum de l'Activitat 4.
- Aprendre a personalitzar un gràfic bàsic: títol, noms dels eixos, colors.
- Construir el mateix gràfic a Google Sheets amb l'assistent de gràfics.
- Interpretar críticament què mostra —i què no mostra— aquest primer gràfic (per exemple, per què la darrera barra "no és comparable del tot" amb les altres, tal com vam veure a l'Activitat 4).

## Pas 1 — Tenir les dades a punt

Continuem amb la taula `resum` que vam construir a l'Activitat 4 (columnes `decada`,
`n_total`, `n_tropicals`, `percentatge`). Si no la tens desada, torna-la a calcular:

```r
estiu$decada <- (estiu$ANY %/% 10) * 10
estiu$tropical <- estiu$TN >= 20

total_dec <- aggregate(tropical ~ decada, data = estiu, FUN = length)
trop_dec  <- aggregate(tropical ~ decada, data = estiu, FUN = sum)

resum <- data.frame(
  decada = total_dec$decada,
  n_total = total_dec$tropical,
  n_tropicals = trop_dec$tropical
)
resum$percentatge <- round(100 * resum$n_tropicals / resum$n_total, 2)
```

## Pas 2 — El gràfic més senzill possible

```r
barplot(resum$percentatge)
```

Amb una única línia ja obtens un diagrama de barres! Però, tal com està, el gràfic
és difícil d'interpretar: no sabem què representa cada barra ni què hi ha als eixos.
Anem a millorar-lo pas a pas.

## Pas 3 — Afegint noms, títol i eixos

```r
barplot(resum$percentatge,
        names.arg = resum$decada,
        main = "Percentatge de nits tropicals per dècada (Nulles, estiu)",
        xlab = "Dècada",
        ylab = "% de nits tropicals",
        col = "steelblue",
        ylim = c(0, 30))
```

**Explicació de cada argument (a R, els arguments d'una funció es poden indicar amb
`nom = valor`, en l'ordre que vulguis):**

| Argument | Què fa |
|---|---|
| `resum$percentatge` | El **primer argument** (sense nom): els valors que determinen l'alçada de cada barra. |
| `names.arg = resum$decada` | Les etiquetes que es mostren sota cada barra (aquí, l'any d'inici de cada dècada: 1950, 1960...). |
| `main = "..."` | El **títol** del gràfic, a la part superior. |
| `xlab = "..."` | El nom de l'**eix horitzontal** (eix X). |
| `ylab = "..."` | El nom de l'**eix vertical** (eix Y). |
| `col = "steelblue"` | El **color** de les barres. R reconeix molts noms de colors en anglès (`"steelblue"`, `"tomato"`, `"forestgreen"`...); també es poden fer servir codis hexadecimals com `"#2a78d6"`. |
| `ylim = c(0, 30)` | Els **límits de l'eix Y**: aquí forcem que vagi de 0 a 30, perquè totes les dècades es puguin comparar amb la mateixa escala (per defecte, R ajustaria l'escala automàticament al valor màxim, cosa que de vegades fa que els gràfics de dos anàlisis diferents no es puguin comparar visualment). |

!!! note "Mini manual R: arguments amb nom vs. sense nom"

    Fixa't que `resum$percentatge` no porta `nom =` davant: és l'**argument
    posicional** (el primer que `barplot()` espera, tal com indica la seva ajuda
    —`?barplot`—). La resta d'arguments sí que porten nom (`main =`, `col =`...)
    perquè `barplot()` en té molts i és més clar (i evita errors) indicar
    explícitament a quin es refereix cada valor, en lloc de memoritzar-ne l'ordre
    exacte.

## Pas 4 — El mateix gràfic a Google Sheets

1. Amb la taula resum (dècada i percentatge) ja construïda a l'Activitat 4 —ja sigui amb fórmules soltes o amb la taula dinàmica—, selecciona les dues columnes (`decada` i `percentatge`).
2. **Inserir → Gràfic**.
3. A la pestanya "Configuració", tria el tipus **"Gràfic de columnes"** (l'equivalent, a Sheets, del diagrama de barres vertical de R).
4. A la pestanya "Personalitza", pots afegir el títol del gràfic i dels eixos, canviar el color de les barres, i fixar l'escala de l'eix vertical (per exemple, de 0 a 30), tal com hem fet a R amb `ylim`.

Compara els dos gràfics (el de R i el de Sheets): haurien de mostrar exactament el
mateix patró, encara que l'aspecte visual sigui una mica diferent.

## Pas 5 — Una millora opcional: marcar la dècada incompleta

Com vam veure a l'Activitat 4, la dècada de 2020 només té 6 anys (encara no ha
acabat), mentre que la resta en tenen 10. Per no confondre qui miri el gràfic, és
una bona pràctica distingir visualment aquesta última barra:

```r
colors <- c(rep("steelblue", 7), "tomato")   # 7 dècades completes + 1 incompleta

barplot(resum$percentatge,
        names.arg = resum$decada,
        main = "Percentatge de nits tropicals per dècada (Nulles, estiu)",
        xlab = "Dècada", ylab = "% de nits tropicals",
        col = colors, ylim = c(0, 30))
```

**Explicació:**

- `rep(valor, vegades)`: la funció `rep()` ("repeteix") crea un vector repetint un valor. `rep("steelblue", 7)` crea un vector amb el text `"steelblue"` repetit 7 vegades.
- `c(rep("steelblue", 7), "tomato")`: combinem (amb `c()`, com ja hem vist) aquest vector de 7 colors amb un vuitè color diferent (`"tomato"`), per a la dècada de 2020.
- Ara `col = colors` assigna un color diferent a cadascuna de les 8 barres, en lloc d'un únic color per a totes.

## El gràfic resultant: què hi observem?

El diagrama de barres mostra visualment el mateix patró que ja havíem llegit a la
taula de l'Activitat 4: una tendència **clarament ascendent** des de la dècada de
1970 (el valor més baix, 2,62%) fins a la dècada actual (28,14%, tot i ser
incompleta). Un gràfic ben fet permet detectar d'un cop d'ull el que a la taula de
números costa més de veure: per exemple, que el creixement no és perfectament
constant (hi ha una pujada i una baixada entre 1950–1970 abans que comenci la
pujada sostinguda a partir de 1980–1990).

**Advertència que cal recordar sempre en llegir aquest gràfic:** la darrera barra
(2020) representa només 6 anys, no 10 com la resta. Encara que hem fet servir
percentatges (no valors absoluts) precisament per fer la comparació més justa, un
percentatge calculat sobre menys anys és, en general, una mica menys fiable (més
sensible a un any concret especialment càlid o fresc) que un calculat sobre 10 anys
sencers. Aquesta idea —que mostres més petites donen resultats menys estables— la
retrobarem més endavant al curs, quan parlem de com d'"anòmal" és realment aquest
darrer valor.

## Per practicar

a) Modifica el gràfic de R perquè, en lloc del percentatge, mostri el **nombre absolut** de nits tropicals (`resum$n_tropicals`) per dècada. Compara visualment aquest gràfic amb el de percentatges: quina diferència important hi observes per a la barra de 2020?

b) A Sheets, prova de canviar el tipus de gràfic de "columnes" (barres verticals) a "barres" (horitzontals). Quin dels dos et sembla més fàcil de llegir per a aquestes dades, amb vuit categories ordenades cronològicament?

c) Escriu, amb les teves paraules, dues frases que resumeixin què li explicaries a algú que veiés per primer cop aquest gràfic, sense haver vist la taula de dades ni els passos anteriors.

## Resum de l'activitat (i tancament del bloc)

- Hem construït el nostre primer gràfic amb R (`barplot()`) i amb Sheets (gràfic de columnes), a partir de la taula de freqüències per dècada de l'Activitat 4.
- Hem après a personalitzar un gràfic bàsic de R: títol, eixos, colors, escala.
- Hem practicat una idea important d'anàlisi de dades: **avisar visualment** quan un grup de la comparació no és igual que la resta (la dècada incompleta de 2020).
- Amb aquesta activitat tanquem el recorregut complet del bloc: **dades brutes →
  variable pròpia (nit tropical) → filtratge → taula de freqüències (dicotòmica, per
  intervals, per dècada) → gràfic**. Aquest mateix recorregut —neteja de dades,
  construcció de variables, taules i gràfics— és el que tornarem a fer, amb eines
  noves, en cadascun dels blocs següents del curs (representacions gràfiques,
  mesures de centralitat, dispersió i regressió), sempre sobre aquest mateix conjunt
  de dades de Nulles.
