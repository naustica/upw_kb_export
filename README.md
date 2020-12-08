# Export von Unpaywall-Datensätze für die KB-Datenbank

## Voraussetzungen

- [unpigz](http://manpages.ubuntu.com/manpages/eoan/en/man1/pigz.1.html)
- [parallel](https://linux.die.net/man/1/parallel)
- [Python3](https://www.python.org)
  - [Dask](https://dask.org)

## Setup

Installieren der benötigten Pakete

```bash
apt-get install pigz
apt-get install python3.7
pip3 install "dask[dataframe]"
```

Erstellen folgender Ordnerstruktur

```bash
tree export-ordner
export-ordner
├──filter.py
├──head.txt
├──kb_doi_list_w_header.csv   [DOI-Liste mit Header "doi"!]
├──merge
├──output
├──output_kb
├──output_upw
├──unpaywall_snapshot_2020-10-09T153852.jsonl.gz    [Unpaywall-Snapshot]
├──wos_upw_export_hpc.sh
```

**Wichtig hierbei ist, dass die Ordner output, output_kb und output_upw existieren und leer sind.**

## Skript starten

Das Skript lässt sich mit folgendem Befehl starten.

```bash
sh wos_upw_export.sh
```

Die finale Datei `out.csv` liegt anschließend im Ordner `merge`.

## Skript modifizieren

*Line 1 wos_upw_export.sh:* Dateiname des Unpaywall-Datensnapshots

*Line 1 wos_upw_export.sh:* Anpassung der extrahierten Felder (**Wichtig: Felder müssen auch in der Datei head.txt auftauchen + Reihenfolge!**)

*Line 1, 7, 15 wos_upw_export.sh:* Anpassung der maximalen parallelen Prozesse

*Line 5 filter.py:* Dateiname der DOI-Liste
