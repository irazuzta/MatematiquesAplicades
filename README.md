# Matemàtica Aplicada — 1r de Batxillerat

Apunts de Matemàtica Aplicada, escrits en Markdown i publicats amb
[Zensical](https://zensical.org/).

## Posada en marxa

=== "Windows"

    ```bat
    install.bat
    .venv\Scripts\zensical serve
    ```

=== "Linux i macOS"

    ```bash
    ./install.sh
    .venv/bin/zensical serve
    ```

El servidor local queda a <http://127.0.0.1:8000> i es recarrega sol quan deses un
fitxer.

Per generar el lloc estàtic a `site/`:

```bash
.venv/bin/zensical build --clean
```

## Estructura

```
docs/
  index.md                 pàgina d'inici
  javascripts/katex.js     arrencada de KaTeX
  stylesheets/extra.css    estils propis i regles d'impressió
  assets/dades/            conjunts de dades descarregables (CSV)
  presentacions/
    index.md                introducció i llista de blocs
    01_nom.md, 02_nom.md...  blocs de teoria
    llibre.md                versió contínua per imprimir (només inclusions)
  exercicis/
    index.md                introducció i llista de relacions
    01_nom.md, 02_nom.md...  relacions d'exercicis (numeració contínua)
  laboratori/
    index.md                introducció i llista d'activitats
    00_nom.md, 01_nom.md...  activitats pas a pas amb R i Google Sheets

solucionaris/               solucions dels exercicis — fora de docs/, no es publiquen
```

## Publicació

`.github/workflows/docs.yml` desplega el lloc a GitHub Pages a cada push a `master` o
`main`. Ara mateix el projecte només es treballa en local: el workflow no s'executa
fins que el repositori tingui un remot i s'hi faci push, i cal activar Pages amb
l'origen «GitHub Actions» a la configuració del repositori.

## Nota sobre `zensical.toml`

El fitxer fa servir taules en línia repartides en diverses línies i amb coma final.
Zensical ho llegeix sense problemes (fa servir `tomli`, que ja implementa aquesta part
del esborrany de TOML 1.1), però el `tomllib` de la biblioteca estàndard de Python
—més estricte— no ho accepta. Si algun dia vols validar el `nav` amb `tomllib`,
extreu-lo a part; que `tomllib` es queixi no vol dir que el fitxer estigui malament.
