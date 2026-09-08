# Bloc 1 — Tipus de dades i taules de freqüència

Abans de calcular res, cal saber **de quin tipus de dades disposem**: el tipus de
variable determina si té sentit ordenar-la, acumular-la o agrupar-la en intervals, i
per tant quines eines estadístiques hi podem aplicar. Aquest primer bloc estableix
aquest vocabulari bàsic i la primera eina per resumir dades: la taula de freqüències.

!!! abstract "Definició: població, mostra, individu i variable estadística"

    - **Població**: el conjunt total d'individus que volem estudiar (p. ex., tots els alumnes d'un institut).
    - **Mostra**: una part de la població que s'estudia realment (p. ex., els alumnes de 1r de batxillerat).
    - **Individu**: cada element de la població o mostra (una persona, un objecte, un fet...).
    - **Variable estadística**: la característica que mesurem o observem de cada individu (l'alçada, el color d'ulls, el mitjà de transport...).

## Els dos grans tipus de variable

```
                Variable estadística
                    /          \
          Qualitativa          Quantitativa
          (categories)          (números)
           /       \              /      \
      Nominal   Ordinal      Discreta   Contínua
```

**Qualitativa** vol dir que la variable descriu una qualitat o categoria, no un número
amb el qual es pugui calcular. **Quantitativa** vol dir que s'expressa amb un número
que resulta de comptar o mesurar.

!!! abstract "Definició: variable qualitativa nominal"

    Categories **sense cap ordre natural** entre elles.

    **Exemples:** color d'ulls, mitjà de transport, gènere musical preferit, marca de mòbil.

    No té sentit dir que una categoria és "més gran" o "millor" que una altra: "Bus" no
    és més ni menys que "Cotxe", simplement són diferents.

!!! abstract "Definició: variable qualitativa ordinal"

    Categories que **sí tenen un ordre natural**, però no són números amb els quals es
    puguin fer operacions (sumar, calcular una mitjana...).

    **Exemples:** valoració d'un servei (Molt malament → Molt bé), nivell d'estudis, talla de roba (S, M, L, XL).

    Sí té sentit dir "com a mínim Bé" o "com a màxim Regular", perquè hi ha un ordre clar.

!!! abstract "Definició: variable quantitativa discreta"

    Resulta de **comptar**. Només pot prendre certs valors aïllats (normalment nombres
    enters), mai valors intermedis.

    **Exemples:** nombre de germans, nombre de missatges enviats en un dia, nombre de gols en un partit.

    Entre 1 germà i 2 germans no hi ha cap valor intermedi possible.

!!! abstract "Definició: variable quantitativa contínua"

    Resulta de **mesurar**. Pot prendre, en teoria, qualsevol valor dins un interval
    (encara que a la pràctica l'aparell de mesura limiti la precisió).

    **Exemples:** alçada, pes, temps en una cursa, temperatura.

    Entre 168 cm i 169 cm hi ha infinits valors possibles: 168,3 cm, 168,47 cm...

!!! tip "Propietat: el tipus de variable determina què en podem fer"

    | | Té sentit ordenar/acumular? | Cal agrupar en intervals? |
    |---|:---:|:---:|
    | Nominal | No | No |
    | Ordinal | Sí | No |
    | Discreta | Sí | Normalment no |
    | Contínua | Sí | Gairebé sempre sí |

    Per això el primer pas de qualsevol anàlisi és preguntar-se: de quin tipus de
    variable es tracta?

## La taula de freqüències

!!! info "Notació: freqüències"

    Per a cada valor o categoria $x_i$ de la variable:

    | Freqüència | Símbol | Es calcula com |
    |---|---|---|
    | Absoluta | $n_i$ | El nombre de vegades que apareix $x_i$ |
    | Relativa | $f_i$ | $f_i = \dfrac{n_i}{N}$, amb $N$ el total de dades |
    | Absoluta acumulada | $N_i$ | La suma de $n_i$ i de totes les anteriors (només amb ordre) |
    | Relativa acumulada | $F_i$ | $F_i = \dfrac{N_i}{N}$ |

!!! tip "Propietat: sumes de control"

    $$
    \begin{aligned}
    \sum_i n_i &= N \\
    \sum_i f_i &= 1
    \end{aligned}
    $$

    Comprovar aquestes dues sumes a la fila de totals és la manera més ràpida de
    detectar un error en una taula de freqüències.

!!! example "**Exemple:** mitjà de transport (variable nominal)"

    Mitjà de transport de 30 alumnes. Com que no hi ha ordre entre categories, no
    calculem $N_i$ ni $F_i$.

    | Mitjà de transport | $n_i$ | $f_i$ | $f_i$ (%) |
    |---|---|---|---|
    | Peu | 9 | 0,30 | 30% |
    | Bus | 9 | 0,30 | 30% |
    | Cotxe | 6 | 0,20 | 20% |
    | Metro | 4 | 0,13 | 13,3% |
    | Bicicleta | 2 | 0,07 | 6,7% |
    | **Total** | **30** | **1,00** | **100%** |

!!! example "**Exemple:** valoració d'un servei (variable ordinal)"

    Valoració d'un servei per 25 usuaris. Aquí **sí** té sentit acumular, ordenant
    abans les categories de pitjor a millor.

    | Valoració | $n_i$ | $N_i$ | $f_i$ | $F_i$ |
    |---|---|---|---|---|
    | Molt malament | 2 | 2 | 0,08 | 0,08 |
    | Malament | 4 | 6 | 0,16 | 0,24 |
    | Regular | 8 | 14 | 0,32 | 0,56 |
    | Bé | 7 | 21 | 0,28 | 0,84 |
    | Molt bé | 4 | 25 | 0,16 | 1,00 |
    | **Total** | **25** | — | **1,00** | — |

    Amb les freqüències acumulades podem respondre preguntes com:

    - Quin percentatge ha valorat **com a mínim** "Bé"? $\Rightarrow f_i(\text{Bé}) + f_i(\text{Molt bé}) = 0{,}28 + 0{,}16 = \mathbf{44\%}$
    - Quin percentatge ha valorat **com a màxim** "Regular"? $\Rightarrow F_i(\text{Regular}) = \mathbf{56\%}$

!!! example "**Exemple:** nombre de germans (variable discreta)"

    Nombre de germans de 30 alumnes. Com que els valors tenen un ordre numèric
    natural, s'acumula igual que amb l'ordinal.

    | $x_i$ (germans) | $n_i$ | $N_i$ | $f_i$ | $F_i$ |
    |---|---|---|---|---|
    | 0 | 6 | 6 | 0,20 | 0,20 |
    | 1 | 12 | 18 | 0,40 | 0,60 |
    | 2 | 8 | 26 | 0,27 | 0,87 |
    | 3 | 3 | 29 | 0,10 | 0,97 |
    | 4 | 1 | 30 | 0,03 | 1,00 |
    | **Total** | **30** | — | **1,00** | — |

## Dades contínues: per què cal agrupar-les

Amb una variable contínua (per exemple, l'alçada de 30 alumnes), és molt probable que
gairebé cada dada sigui diferent de les altres. Si féssim una fila per cada valor
exacte, la taula tindria gairebé 30 files d'una sola dada cadascuna: no resumiria res.
La solució és agrupar els valors en **intervals** (també anomenats *classes*).

!!! abstract "Definició: interval, amplitud i marca de classe"

    - **Amplitud de l'interval**: la mida de cada tram (p. ex., 5 cm, 10 anys...). Ha de ser la mateixa per a tots els intervals.
    - **Límits de l'interval**: s'escriu $[a, b)$, és a dir, inclou $a$ però no inclou $b$, de manera que cada dada cau exactament en un únic interval.
    - **Marca de classe**: el punt mitjà de l'interval, $\dfrac{a+b}{2}$. És el valor que "representa" totes les dades d'aquell interval quan calculem mitjanes o altres mesures més endavant.

!!! example "**Exemple:** alçades agrupades en intervals (variable contínua)"

    Alçades (cm) de 30 alumnes, agrupades en intervals d'amplitud 5, des de 155 cm:

    | Interval | Marca de classe | $n_i$ | $N_i$ | $f_i$ | $F_i$ |
    |---|---|---|---|---|---|
    | [155, 160) | 157,5 | 2 | 2 | 0,07 | 0,07 |
    | [160, 165) | 162,5 | 4 | 6 | 0,13 | 0,20 |
    | [165, 170) | 167,5 | 5 | 11 | 0,17 | 0,37 |
    | [170, 175) | 172,5 | 6 | 17 | 0,20 | 0,57 |
    | [175, 180) | 177,5 | 6 | 23 | 0,20 | 0,77 |
    | [180, 185) | 182,5 | 5 | 28 | 0,17 | 0,93 |
    | [185, 190) | 187,5 | 2 | 30 | 0,07 | 1,00 |
    | **Total** | — | **30** | — | **1,00** | — |

    Cada dada s'ha assignat a un únic interval, segons el conveni $[a, b)$: una alumna
    de 165,0 cm cau a $[165, 170)$, no a $[160, 165)$. Percentatge d'alumnes que fa
    menys de 170 cm: $F_i([155,170)) = \dfrac{11}{30} \approx \mathbf{36{,}7\%}$.

!!! warning "Error habitual: acumular freqüències en una variable sense ordre"

    A l'exemple del mitjà de transport no hem calculat $N_i$ ni $F_i$, i no és un
    oblit: **acumular només té sentit quan les categories tenen un ordre**. Dir que
    "el 60% dels alumnes va a peu o en bus" és correcte perquè sumem dues categories
    concretes, però parlar de "la freqüència acumulada fins a Bus" no vol dir res, ja
    que Peu, Bus, Cotxe, Metro i Bicicleta no estan ordenades entre elles: l'ordre en
    què apareixen a la taula és arbitrari.

## Taula resum

| Tipus de variable | Gràfic recomanat |
|---|---|
| Qualitativa nominal | Diagrama de sectors (o de barres, sense ordre fix) |
| Qualitativa ordinal | Diagrama de barres (categories en el seu ordre) |
| Quantitativa discreta | Diagrama de barres (una barra per cada $x_i$) |
| Quantitativa contínua | Histograma i, opcionalment, polígon de freqüències |

!!! note "Nota històrica"

    La primera taula de freqüències "moderna" no la va fer cap matemàtic, sinó un
    comerciant de teixits londinenc. El 1662, John Graunt va publicar *Natural and
    Political Observations Made upon the Bills of Mortality*, on va classificar i
    comptar els registres setmanals de morts de Londres per causa i per parròquia.
    Aquest simple gest de comptar i organitzar dades en una taula es considera el
    naixement de l'estadística descriptiva i de la demografia com a disciplines.

Amb les taules de freqüència ja construïdes, al proper bloc veurem com traduir-les en
gràfics: quina representació toca a cada tipus de variable i com es construeix un
histograma a partir dels intervals que acabem de definir.
