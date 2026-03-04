# LabEconomia Slides

Repository per le slide dinamiche dell'app VR LabEconomia (PICO Neo 3 Eye).

## Struttura

```
docs/
  manifest_student001.json   ← lista slide dello studente 001
  manifest_student002.json   ← lista slide dello studente 002
  student001/
    slide_01.png             ← immagini della presentazione
    slide_02.png
  student002/
    slide_01.png
    slide_02.png
```

## Come aggiornare le slide di uno studente

1. Carica le nuove immagini nella cartella `docs/studentXXX/`
2. Aggiorna il file `docs/manifest_studentXXX.json`
3. **Incrementa il campo `"version"`** (es. da `"1.0"` a `"1.1"`) — questo forza il PICO a ri-scaricare le immagini
4. Fai `git push` → GitHub Pages si aggiorna in ~1 minuto
5. Al prossimo avvio dell'app con WiFi, le nuove slide vengono scaricate automaticamente

## Aggiungere un nuovo studente

1. Crea la cartella `docs/studentNNN/`
2. Carica le immagini nella cartella
3. Crea il file `docs/manifest_studentNNN.json` (copia il formato da uno esistente)
4. Push

## Formato immagini consigliato

- **Risoluzione**: 1920×1080 (16:9) o 1280×720
- **Formato**: PNG o JPEG
- **Dimensione**: < 500 KB per immagine (usa https://tinypng.com per comprimere)
- **Nome file**: usa solo lettere, numeri e underscore (es. `slide_01.png`)

## URL base GitHub Pages

```
https://Ko-Haku.github.io/LabEconomia_Slides/
```

Da impostare nel campo **Manifest Base Url** del componente `SlideDownloader` in Unity.

