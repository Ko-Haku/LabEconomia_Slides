# LabEconomia Slides

Repository per le slide dinamiche dell'app VR **LabEconomia** (PICO Neo 3 Eye).  
Gestisce **5 postazioni/caschetti**, ognuna con le proprie slide.

## Struttura

```
docs/
  manifest_student001.json   ← generato automaticamente
  manifest_student002.json
  manifest_student003.json
  manifest_student004.json
  manifest_student005.json
  student001/                ← immagini caschetto 1
    slide-01.png
    slide-02.png
    ...
  student002/                ← immagini caschetto 2
  student003/                ← immagini caschetto 3
  student004/                ← immagini caschetto 4
  student005/                ← immagini caschetto 5
```

## ⚡ Come aggiornare le slide (metodo più semplice)

> Non serve Python, non serve la riga di comando.  
> I manifest si aggiornano **automaticamente** grazie a una GitHub Action.

1. Vai su **GitHub** → questo repository → cartella `docs/studentXXX/`
2. Clicca **Add file → Upload files**
3. **Trascina** le nuove immagini PNG o JPG (drag & drop)
4. Clicca **Commit changes**
5. ✅ Fatto! Entro ~2 minuti le slide sono disponibili nei visori

### Se vuoi sostituire TUTTE le slide di uno studente

1. Entra nella cartella `docs/studentXXX/` su GitHub
2. Cancella le vecchie immagini (clicca su ogni file → 🗑️ Delete)
3. Carica le nuove immagini come sopra
4. I manifest si rigenerano da soli

## 🎧 Setup iniziale dei 5 caschetti PICO

Ogni caschetto deve sapere "quale studente è". Si configura **una sola volta**:

1. Collega il PICO al PC via USB
2. Abilita **Debug USB** nelle impostazioni sviluppatore del PICO
3. Esegui `CONFIGURA_PICO.bat`
4. Scegli il numero del caschetto (1-5)
5. Ripeti per ogni caschetto

Oppure manualmente con ADB:
```bash
# Esempio: configurare il caschetto 3
echo { "studentId": "student003" } > config.json
adb push config.json /sdcard/Android/data/com.unity.vrtemplate/files/student_config.json
```

## 📝 Formato immagini consigliato

- **Risoluzione**: 1920×1080 (16:9) o 1280×720
- **Formato**: PNG o JPEG
- **Dimensione**: < 500 KB per immagine (usa https://tinypng.com per comprimere)
- **Nome file**: qualsiasi (lettere, numeri, trattini). Vengono ordinate alfabeticamente.

## 🔧 Metodo alternativo (locale)

Se preferisci lavorare in locale (con Python e Git installati):

1. Metti le immagini nella cartella `docs/studentXXX/`
2. Esegui `AGGIORNA_E_PUSHA.bat` (genera i manifest e fa push)
3. Oppure manualmente:
   ```
   python genera_manifest.py
   git add -A && git commit -m "Aggiorno slide" && git push
   ```

## 🌐 URL base GitHub Pages

```
https://Ko-Haku.github.io/LabEconomia_Slides/
```

Configurato nel componente `SlideDownloader` in Unity (campo **Manifest Base Url**).

## Come funziona il flusso completo

```
Tecnico carica immagini su GitHub
        ↓
GitHub Action rigenera manifest_studentXXX.json
        ↓
GitHub Pages pubblica i file (~1-2 min)
        ↓
PICO avvia l'app → SlideDownloader scarica il manifest
        ↓
Confronta la versione: se è nuova, scarica le immagini
        ↓
SlidePresenter mostra le slide nel visore VR
```
