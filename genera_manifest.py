#!/usr/bin/env python3
"""
genera_manifest.py
==================
Scansiona le cartelle docs/<studentId>/ e genera automaticamente
il file docs/manifest_<studentId>.json con tutti i file immagine trovati.

Uso:
    python genera_manifest.py                  # aggiorna TUTTI gli studenti
    python genera_manifest.py student001       # aggiorna solo student001

Il nome dei file non importa — vengono ordinati alfabeticamente.
Formati supportati: .png .jpg .jpeg .webp

Dopo aver eseguito lo script, fai git add + commit + push normalmente.
"""

import os
import json
import sys
import re

DOCS_DIR = os.path.join(os.path.dirname(__file__), "docs")
BASE_URL  = "https://ko-haku.github.io/LabEconomia_Slides"
IMAGE_EXT = {".png", ".jpg", ".jpeg", ".webp"}

def is_student_folder(name):
    """Considera student folder qualsiasi cartella dentro docs/ tranne quelle speciali."""
    skip = {"__pycache__", ".git"}
    return name not in skip

def generate_manifest(student_id: str, version: str = None):
    folder = os.path.join(DOCS_DIR, student_id)
    if not os.path.isdir(folder):
        print(f"[SKIP] Cartella non trovata: {folder}")
        return

    # Raccoglie tutte le immagini, ordinate alfabeticamente
    images = sorted([
        f for f in os.listdir(folder)
        if os.path.splitext(f)[1].lower() in IMAGE_EXT
    ])

    if not images:
        print(f"[WARN] Nessuna immagine in {folder}")

    # Legge la versione esistente e la incrementa automaticamente
    manifest_path = os.path.join(DOCS_DIR, f"manifest_{student_id}.json")
    if version is None:
        if os.path.exists(manifest_path):
            try:
                with open(manifest_path, "r", encoding="utf-8") as f:
                    old = json.load(f)
                old_ver = old.get("version", "1.0")
                # Incrementa la parte decimale
                parts = old_ver.split(".")
                parts[-1] = str(int(parts[-1]) + 1)
                version = ".".join(parts)
            except Exception:
                version = "1.0"
        else:
            version = "1.0"

    slides = [
        {
            "name": os.path.splitext(img)[0],
            "url": f"{BASE_URL}/{student_id}/{img}"
        }
        for img in images
    ]

    manifest = {
        "version": version,
        "slides": slides
    }

    with open(manifest_path, "w", encoding="utf-8") as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)

    print(f"[OK] {manifest_path} — {len(slides)} slide, versione {version}")
    for s in slides:
        print(f"     - {s['name']}  ->  {s['url']}")

def main():
    if not os.path.isdir(DOCS_DIR):
        print(f"[ERROR] Cartella docs/ non trovata: {DOCS_DIR}")
        sys.exit(1)

    if len(sys.argv) > 1:
        # Aggiorna solo lo studente specificato
        for student_id in sys.argv[1:]:
            generate_manifest(student_id)
    else:
        # Aggiorna tutti i folder dentro docs/
        entries = [
            e for e in os.listdir(DOCS_DIR)
            if os.path.isdir(os.path.join(DOCS_DIR, e)) and is_student_folder(e)
        ]
        if not entries:
            print("[WARN] Nessuna cartella studente trovata in docs/")
        for student_id in sorted(entries):
            generate_manifest(student_id)

    print("\nFatto! Ora esegui:")
    print("  git add -A")
    print('  git commit -m "Update manifests"')
    print("  git push origin main")

if __name__ == "__main__":
    main()

