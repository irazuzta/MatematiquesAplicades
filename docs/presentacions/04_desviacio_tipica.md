# Bloc 4 — Mesures de dispersió: la desviació típica

Una classe amb nota mitjana 5 pot donar-se de maneres molt diferents: la meitat pot
treure un 10 i l'altra meitat un 0, tothom pot treure exactament un 5, o les notes es
poden repartir de manera uniforme entre 0 i 10. **Mateixa mitjana, situacions
completament diferents.** Necessitem un número que mesuri com de repartides estan les
dades al voltant del centre: això és el que fan les **mesures de dispersió**.

!!! abstract "Definició: variança i desviació típica"

    Per a cada dada, la seva desviació respecte a la mitjana és $x_i - \bar{x}$. Ja
    sabem (Bloc 3) que aquestes desviacions sumen sempre zero; per evitar que es
    cancel·lin, les elevem al quadrat abans de sumar-les. La **variança** és la
    mitjana d'aquestes desviacions al quadrat:

    $$
    s^2 = \frac{\sum (x_i-\bar{x})^2}{n}
    $$

    La variança té un inconvenient: les seves unitats són el quadrat de les unitats
    originals (cm² si les dades són en cm), cosa que la fa difícil d'interpretar. Per
    tornar a les unitats originals, es defineix la **desviació típica** com l'arrel
    quadrada de la variança:

    $$
    s = \sqrt{s^2} = \sqrt{\frac{\sum (x_i-\bar{x})^2}{n}}
    $$

    Amb una taula de freqüències, $s^2 = \sum (x_i-\bar{x})^2 \cdot f_i$; amb dades
    agrupades en intervals, $s^2 = \sum (m_i-\bar{x})^2 \cdot f_i$.

!!! example "**Exemple:** nombre de germans de 30 alumnes ($\bar{x} = 41/30 \approx 1{,}37$)"

    | $x_i$ | $n_i$ | $x_i-\bar{x}$ | $(x_i-\bar{x})^2$ |
    |---|---|---|---|
    | 0 | 6 | −1,37 | 1,87 |
    | 1 | 12 | −0,37 | 0,13 |
    | 2 | 8 | 0,63 | 0,40 |
    | 3 | 3 | 1,63 | 2,67 |
    | 4 | 1 | 2,63 | 6,93 |

    Com al Bloc 3, calculem amb els $n_i$ exactes i dividim per $N$ un sol cop al
    final, per no arrossegar l'arrodoniment dels $f_i$:

    $$
    s^2 = \frac{\sum n_i(x_i-\bar{x})^2}{30} \approx \mathbf{1{,}03} \quad\Rightarrow\quad s = \sqrt{1{,}03} \approx \mathbf{1{,}02} \text{ germans}
    $$

!!! example "**Exemple:** alçades de 30 alumnes, agrupades en intervals ($\bar{x} = 173$ cm)"

    | Interval | $m_i$ | $n_i$ | $m_i-\bar{x}$ | $(m_i-\bar{x})^2$ |
    |---|---|---|---|---|
    | [155,160) | 157,5 | 2 | −15,5 | 240,25 |
    | [160,165) | 162,5 | 4 | −10,5 | 110,25 |
    | [165,170) | 167,5 | 5 | −5,5 | 30,25 |
    | [170,175) | 172,5 | 6 | −0,5 | 0,25 |
    | [175,180) | 177,5 | 6 | 4,5 | 20,25 |
    | [180,185) | 182,5 | 5 | 9,5 | 90,25 |
    | [185,190) | 187,5 | 2 | 14,5 | 210,25 |

    $$
    s^2 = \frac{\sum n_i(m_i-\bar{x})^2}{30} \approx \mathbf{68{,}92} \quad\Rightarrow\quad s = \sqrt{68{,}92} \approx \mathbf{8{,}3} \text{ cm}
    $$

!!! tip "Propietat: característiques de la variança i la desviació típica"

    - Utilitzen **totes** les dades: cada valor hi compta (com la mitjana).
    - Són **molt sensibles** a valors atípics: en elevar al quadrat, una dada molt allunyada pesa encara més que en la mitjana.
    - $s$ té les mateixes unitats que les dades; $s^2$ té unitats al quadrat (per això $s$ és més fàcil d'interpretar).
    - $s = 0$ únicament quan totes les dades són idèntiques (no hi ha cap dispersió).
    - Només tenen sentit per a variables **quantitatives**.

## Tornem a l'exemple inicial, ara amb números

!!! example "**Exemple:** tres classes amb la mateixa mitjana, dispersions molt diferents"

    | Escenari | Desviació típica |
    |---|---|
    | Meitat treu 10, meitat treu 0 | $s = 5$ |
    | Tothom treu un 5 | $s = 0$ |
    | Notes uniformes entre 0 i 10 (11 valors possibles) | $s \approx 3{,}16$ |

    La desviació típica **sí que distingeix** aquestes tres situacions, tot i que la
    mitjana és idèntica als tres casos: com més gran és $s$, més "escampades" estan
    les dades.

## Interpretant la desviació típica: la desigualtat de Txebixev

La desviació típica, per si sola, ja diu molt: sigui quina sigui la forma de la
distribució (no cal que sigui simètrica ni "en forma de campana"), la majoria de les
dades s'acumulen a prop de la mitjana, a una distància mesurada en desviacions
típiques.

!!! tip "Propietat: desigualtat de Txebixev"

    | Distància a la mitjana | Percentatge mínim de dades |
    |:---:|:---:|
    | $\bar{x} \pm 2s$ | almenys el **75%** |
    | $\bar{x} \pm 3s$ | almenys el **89%** |

    Val per a **qualsevol** conjunt de dades, sense excepcions: no cal saber res de la
    forma de la distribució.

!!! example "**Exemple:** Txebixev amb les alçades ($\bar{x}=173$ cm, $s\approx8{,}3$ cm)"

    - Interval $\bar{x} \pm 2s = [156{,}4,\ 189{,}6]$ cm $\Rightarrow$ Txebixev garanteix que **com a mínim el 75%** dels alumnes hi són.
    - Interval $\bar{x} \pm 3s = [148{,}1,\ 197{,}9]$ cm $\Rightarrow$ **com a mínim el 89%**.

    Si mirem les dades reals (alçades entre 158 i 187 cm), el **100%** dels alumnes
    cauen dins del primer interval: Txebixev dona un mínim garantit, però a la pràctica
    la proporció real sol ser molt més alta.

!!! warning "Error habitual: confondre Txebixev amb la regla 68-95-99,7"

    És fàcil recordar de sentir a dir que "a $\pm 2s$ hi ha el 95% de les dades i a
    $\pm 3s$ el 99,7%". Això és la **regla empírica**, i només val per a dades que
    segueixen (aproximadament) una **distribució normal** — la coneguda "campana de
    Gauss", que veurem més endavant. La desigualtat de Txebixev és més feble (75% i
    89%, no 95% i 99,7%) precisament perquè **val sempre**, per a qualsevol forma de
    distribució. Aplicar els percentatges de la regla empírica a unes dades que no
    saps si són normals és un error habitual: Txebixev dona una cota mínima garantida;
    la regla empírica dona un valor aproximat, però només sota una condició que cal
    comprovar.

## Taula resum

| Mesura | Símbol | Unitats | Sensibilitat a atípics |
|---|---|---|---|
| Variança | $s^2$ | Quadrat de les de la variable | Alta |
| Desviació típica | $s = \sqrt{s^2}$ | Les mateixes que la variable | Alta |

!!! note "Nota històrica"

    El terme **desviació típica** el va encunyar Karl Pearson en unes classes de
    1893 (publicades el 1894): abans, cada autor feia servir una notació diferent
    per mesurar la dispersió. La desigualtat que porta el nom de Txebixev té, de
    fet, dos pares: el matemàtic francès Irénée-Jules Bienaymé en va demostrar una
    primera versió el 1853, i el rus Pafnuti Txebixev en va publicar la versió
    general —la que fem servir avui— el 1867.

Al proper bloc treballarem els **percentils, els quartils i el diagrama de caixa**,
que permeten descriure la dispersió a partir de l'ordre de les dades i detectar
valors atípics.
