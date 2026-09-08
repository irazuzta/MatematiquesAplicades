# Bloc 3 — Mesures de centralitat

Amb les taules de freqüències i els gràfics (Blocs 1 i 2) descrivim tota la
distribució de les dades. Sovint, però, interessa resumir-la en un sol valor que
sigui representatiu. Les tres mesures de centralitat més habituals són la
**mitjana**, la **mediana** i la **moda**: cadascuna es calcula d'una manera
diferent i és adequada per a un tipus de variable o un altre.

!!! tip "Propietat: quina mesura es pot calcular segons el tipus de variable"

    | Tipus de variable | Moda | Mediana | Mitjana |
    |---|:---:|:---:|:---:|
    | Nominal | Sí | No | No |
    | Ordinal | Sí | Sí | No |
    | Discreta | Sí | Sí | Sí |
    | Contínua (agrupada) | Sí (interval modal) | Sí (interval medià) | Sí |

    La mitjana i la mediana exigeixen valors numèrics (o, la mediana, com a mínim un
    ordre); la moda no exigeix res més que poder comptar freqüències.

## La mitjana

!!! abstract "Definició: mitjana aritmètica"

    Donat un conjunt de $n$ dades numèriques $x_1, x_2, \dots, x_n$:

    $$
    \bar{x} = \frac{\sum x_i}{n}
    $$

    Si les dades ja estan agrupades en una taula de freqüències, amb valors $x_i$ i
    freqüències absolutes $n_i$ (o relatives $f_i$):

    $$
    \bar{x} = \frac{\sum x_i \cdot n_i}{N} = \sum x_i \cdot f_i
    $$

    Quan les dades estan agrupades en intervals, s'aproxima cada interval per la seva
    marca de classe $m_i$: $\bar{x} = \sum m_i \cdot f_i$.

    Només té sentit per a variables **quantitatives**: cal poder sumar les dades.

!!! example "**Exemple:** nombre de germans de 30 alumnes (Bloc 1, Exemple 3)"

    | $x_i$ (germans) | $n_i$ |
    |---|---|
    | 0 | 6 |
    | 1 | 12 |
    | 2 | 8 |
    | 3 | 3 |
    | 4 | 1 |

    $$
    \bar{x} = \frac{0\cdot6 + 1\cdot12 + 2\cdot8 + 3\cdot3 + 4\cdot1}{30} = \frac{41}{30} \approx \mathbf{1{,}37} \text{ germans}
    $$

!!! example "**Exemple:** alçades de 30 alumnes, agrupades en intervals (Bloc 1, Exemple 4)"

    | Interval | $m_i$ | $n_i$ |
    |---|---|---|
    | [155,160) | 157,5 | 2 |
    | [160,165) | 162,5 | 4 |
    | [165,170) | 167,5 | 5 |
    | [170,175) | 172,5 | 6 |
    | [175,180) | 177,5 | 6 |
    | [180,185) | 182,5 | 5 |
    | [185,190) | 187,5 | 2 |

    $$
    \bar{x} = \frac{157{,}5\cdot2 + \dots + 187{,}5\cdot2}{30} = \frac{5190}{30} = \mathbf{173} \text{ cm}
    $$

!!! warning "Error habitual: arrodonir els $f_i$ abans de multiplicar"

    A l'exemple dels germans, si multipliquem pels $f_i$ **ja arrodonits** de la
    taula del Bloc 1 (0,20 / 0,40 / 0,27 / 0,10 / 0,03) el resultat surt **1,36**, no
    1,37:

    $$
    0\cdot0{,}20 + 1\cdot0{,}40 + 2\cdot0{,}27 + 3\cdot0{,}10 + 4\cdot0{,}03 = 1{,}36
    $$

    La diferència ve de $f_i = 8/30 = 0{,}2\overline{6}$, que la taula arrodoneix a
    $0{,}27$. És un error petit, però es pot evitar: per calcular la mitjana és més
    fiable fer servir directament els $n_i$ (nombres enters, sense arrodonir) i
    dividir per $N$ un sol cop al final, com a l'exemple de dalt.

!!! tip "Propietat: característiques de la mitjana"

    - Utilitza **totes** les dades: cada valor hi compta.
    - És el "centre de gravetat" del conjunt: $\sum (x_i-\bar{x}) = 0$.
    - És **molt sensible** a valors atípics o errors: una sola dada extrema pot desplaçar-la molt.
    - No cal que coincideixi amb cap valor real de la variable (1,37 germans no és un valor possible, però és el que "equilibra" les dades).
    - Només es pot calcular per a variables quantitatives.

## La mediana

!!! abstract "Definició: mediana"

    Ordenades les dades de menor a major, la mediana és el valor que deixa el 50%
    per sota i el 50% per sobre.

    - Si el nombre de dades $n$ és **imparell**: la mediana és el valor central.
    - Si $n$ és **parell**: la mediana és la mitjana dels dos valors centrals.

    A diferència de la mitjana, la mediana només necessita l'**ordre** de les dades,
    no el seu valor exacte.

!!! info "Notació: localitzar la mediana amb una taula de freqüències"

    Amb una taula de freqüències, la mediana és el primer valor $x_i$ per al qual
    $\dfrac{N_i}{N} \ge 0{,}5$.

!!! example "**Exemple:** nombre de germans de 30 alumnes"

    | $x_i$ (germans) | $n_i$ | $N_i$ | $N_i/N$ |
    |---|---|---|---|
    | 0 | 6 | 6 | 0,20 |
    | **1** | **12** | **18** | **0,60** |
    | 2 | 8 | 26 | 0,87 |

    $N_i/N = 0{,}20 < 0{,}5$ per a $x_i=0$, i ja $0{,}60 \ge 0{,}5$ per a $x_i=1$
    $\Rightarrow$ **mediana = 1 germà**.

!!! example "**Exemple:** valoració d'un servei per 25 usuaris — variable ordinal (Bloc 1, Exemple 2)"

    | Valoració | $n_i$ | $N_i$ | $N_i/N$ |
    |---|---|---|---|
    | Molt malament | 2 | 2 | 0,08 |
    | Malament | 4 | 6 | 0,24 |
    | **Regular** | **8** | **14** | **0,56** |
    | Bé | 7 | 21 | 0,84 |

    **Mediana = "Regular"** (és el primer valor amb $N_i/N \ge 0{,}5$). Com que les
    categories ordinals tenen ordre encara que no siguin números, també s'hi pot
    calcular la mediana — però no la mitjana.

!!! example "**Exemple:** alçades de 30 alumnes, agrupades en intervals"

    | Interval | $n_i$ | $N_i$ | $N_i/N$ |
    |---|---|---|---|
    | [165,170) | 5 | 11 | 0,37 |
    | **[170,175)** | **6** | **17** | **0,57** |

    Interval medià $=[170,175)$. En aquest bloc l'aproximem pel seu punt mitjà:
    **mediana $\approx$ 172,5 cm**. Més endavant, en parlar de percentils, afinarem
    aquest càlcul per interpolació.

!!! tip "Propietat: característiques de la mediana"

    - Utilitza només l'**ordre** de les dades, no la seva magnitud exacta.
    - És **poc sensible** a valors atípics: una dada absurdament gran o petita gairebé no la mou.
    - Es pot calcular per a variables quantitatives i qualitatives **ordinals** (no per a nominals, que no tenen ordre).
    - Com que ignora la magnitud exacta de les dades, no sempre aprofita tota la informació disponible.

## La moda

!!! abstract "Definició: moda i interval modal"

    La moda és el valor (o categoria) amb **més freqüència**. Es pot calcular per a
    **qualsevol tipus de variable**, també la nominal. Pot no ser única: si dos o més
    valors comparteixen la freqüència màxima, la distribució és **bimodal** (o
    multimodal). Amb dades contínues agrupades, parlem d'**interval modal**.

!!! example "**Exemple:** mitjà de transport de 30 alumnes (Bloc 1, Exemple 1)"

    | Mitjà de transport | $n_i$ |
    |---|---|
    | **Peu** | **9** |
    | **Bus** | **9** |
    | Cotxe | 6 |
    | Metro | 4 |
    | Bicicleta | 2 |

    **Moda bimodal:** Peu i Bus (9 alumnes cadascun).

!!! example "**Exemple:** alçades de 30 alumnes, agrupades en intervals"

    | Interval | $n_i$ |
    |---|---|
    | [165,170) | 5 |
    | **[170,175)** | **6** |
    | **[175,180)** | **6** |
    | [180,185) | 5 |

    **Intervals modals:** $[170,175)$ i $[175,180)$, empatats a 6 alumnes. A
    diferència de la mitjana i la mediana, aquí no obtenim un punt exacte, sinó
    l'interval (o intervals) on es concentren més dades.

!!! tip "Propietat: característiques de la moda"

    - No es veu afectada per valors extrems: només compta freqüències.
    - Es pot calcular per a variables nominals, ordinals, discretes i contínues (via interval modal).
    - Pot no ser única (bimodal/multimodal) o, si totes les freqüències s'assemblen, pot no aportar gaire informació.
    - Utilitza molt poca informació del conjunt de dades: només mira quin valor es repeteix més.

## Interpretació: l'efecte d'un valor atípic

Tornem al nombre de germans (Bloc 1, Exemple 3). Suposem que, per un error de
transcripció, una de les sis dades "0" s'hagués registrat com "40":

!!! example "**Exemple:** un error de transcripció dispara la mitjana"

    | | Sense error | Amb l'error |
    |---|---|---|
    | Mitjana | $\dfrac{41}{30}\approx 1{,}37$ germans | $\dfrac{0\cdot5+1\cdot12+2\cdot8+3\cdot3+4\cdot1+40\cdot1}{30}=\dfrac{81}{30}=\mathbf{2{,}70}$ germans |
    | Mediana | 1 germà | **1 germà** (no canvia) |

    La mitjana es dispara perquè suma el valor extrem tal qual; la mediana gairebé no
    es mou perquè només mira la posició central. Per això **convé calcular sempre les
    dues juntes**: si difereixen molt, és senyal de dades asimètriques o d'un valor
    atípic que val la pena revisar.

## Taula resum

| Mesura | Utilitza | Sensibilitat a valors atípics | Es pot calcular a... |
|---|---|---|---|
| Mitjana | El valor numèric de cada dada | Alta | Variables quantitatives |
| Mediana | Només l'ordre de les dades | Baixa | Quantitatives i ordinals |
| Moda | Només la freqüència | Cap | Qualsevol tipus de variable |

Un únic valor de centralitat no diu res sobre com es **dispersen** les dades al seu
voltant: dues classes poden tenir la mateixa mitjana de notes i, tot i així, una
tenir-les molt agrupades i l'altra molt escampades. Això és el que veurem al proper
bloc amb les **mesures de dispersió**.
