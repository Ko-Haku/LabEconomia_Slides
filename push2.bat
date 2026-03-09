@echo off
cd /d "D:\Unity\LabEconomia\LabEconomia_Slides_temp"
echo === GIT ADD ALL ===
git add -A
echo === GIT STATUS ===
git status
echo === GIT COMMIT ===
git commit -m "Rename slides to slide_01-05, fix manifest URLs, add index.html"
echo === GIT PUSH ===
git push origin main
echo === DONE ===

