# Laboratori

Activitats pas a pas per treballar l'estadística amb eines reals: **RStudio** i
**Google Sheets**. Totes giren al voltant del mateix conjunt de dades —el registre
diari de temperatures de l'estació de Nulles/Valls—, de manera que cada activitat
reutilitza el que ja saps fer i hi afegeix una eina o un càlcul nou.

[:material-database: Descarrega el conjunt de dades (nulles_dades_climatiques_diaries.txt)](../assets/dades/nulles_dades_climatiques_diaries.txt){ .md-button }

## Apartats

0. [Primer contacte amb les dades](00_primer_contacte.md) — carregar el registre de Nulles/Valls a R i a Sheets, i classificar-ne les variables.
1. [Una variable dicotòmica](01_variable_dicotomica.md) — construir "nit tropical" (Sí/No) i la seva taula de freqüències.
2. [Filtrar els mesos d'estiu](02_filtrar_mesos_estiu.md) — quedar-nos només amb juny–setembre abans de calcular.
3. [Taula amb intervals](03_taula_intervals.md) — agrupar la temperatura mínima en intervals, amb `cut()` i `FREQÜÈNCIA`.
4. [Agrupar per dècades](04_agrupar_decades.md) — `aggregate()` i taules dinàmiques per veure l'evolució 1950–2025.
5. [El primer gràfic](05_primer_grafic.md) — un diagrama de barres amb `barplot()` i amb Sheets.
6. [Gràfics I: sectors, barres i Pareto](06_grafics_sectors_barres_pareto.md) — repartiment de les nits tropicals per mes, i comparació abans i ara.
7. [Gràfics II: histogrames i línies](07_grafics_histogrames_linies.md) — histogrames, polígons de freqüències i sèries temporals de `TN`.
8. [Mitjana, mediana i moda](08_centralitat_mitjana_mediana_moda.md) — un estiu «típic» a Nulles i la sensibilitat als valors extrems.
9. [Rang, variància i desviació típica](09_dispersio_rang_variancia_desviacio.md) — dispersió per dècades i el teorema de Txebixev amb dades reals.
10. [Percentils, quartils i boxplot](10_percentils_quartils_boxplot.md) — el llindar dels 20 ºC com a percentil i boxplots per dècada.
