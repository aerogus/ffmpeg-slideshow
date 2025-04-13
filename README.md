# ffmpeg-slideshow

Génération d'une vidéo de 10 secondes avec `ffmpeg` respectant le scénario suivant :

```
00:00:00 -> 00:00:01 : Ø
00:00:01 -> 00:00:03 : red
00:00:03 -> 00:00:04 : Ø
00:00:04 -> 00:00:05 : white
00:00:05 -> 00:00:06 : Ø
00:00:06 -> 00:00:07 : pink
00:00:07 -> 00:00:08 : Ø
00:00:08 -> fin      : blue
```

## Exécution

```bash
./run.sh
- Génération pink.png : 0xFF00CC@1.0
- Génération blue.png : 0x0000FF@1.0
- Génération transparent.png : 0x000000@0.0
- Génération black.png : 0x000000@1.0
- Génération red.png : 0xFF0000@1.0
- Génération white.png : 0xFFFFFF@1.0
- Génération green.png : 0x00FF00@1.0
- Génération output.mp4
- Ménage pink.png
- Ménage blue.png
- Ménage transparent.png
- Ménage black.png
- Ménage red.png
- Ménage white.png
- Ménage green.png
```

## Résultat

Conversion de .mp4 en .gif pour prévisualisation :

![Prévisualisation de la vidéo générée](output.gif)

## Notes

- Ne marche pas sous bash v3 de MacOS -> installer la v5 via homebrew : `brew install bash`. Testé sous bash 5.2
- dans le scénario, la durée peut être en `s` ou `ms`
- les fichiers doivent avoir le même format de couleurs (ex: `rgba` si `png`)
- pas possible de mixer `jpg` + `png`
- la dernière image est affichée jusqu'à la fin, pas besoin de specifier une `duration`
- testé avec `ffmpeg 7.1.1`

## Ressources

- https://trac.ffmpeg.org/wiki/Slideshow
- https://stackoverflow.com/questions/46952350/ffmpeg-concat-demuxer-with-duration-filter-issue
