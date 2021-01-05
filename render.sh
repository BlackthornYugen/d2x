#!/usr/bin/env bash
set -e
PLANT_JAR="plantuml.jar"
PLANT_URL="http://sourceforge.net/projects/plantuml/files/plantuml.1.2020.26.jar/download"
PLANT_HASH="504dd55fb8884088f374c07753689a3c5a4bd7f9e6ac16cc93146f5c4e530fcd"

# Prereq: PlantUML Jar
wget --no-clobber --output-document=${PLANT_JAR} $PLANT_URL || true # don't abort on wget fail
sha256sum --check <<< "${PLANT_HASH} ${PLANT_JAR}" # Abort if hashcheck fails

# cleanup
rm -rf out/*

for file in *.pu ; do
 java -jar ${PLANT_JAR} -enablestats -htmlstats -output out/${file%.*} ${file}      # Render PNGs
 java -jar ${PLANT_JAR} -enablestats -htmlstats -output out/${file%.*} -tsvg ${file} # Render SVGs
done

# Prereq: Imagemagic for gif
# yum install ImageMagick (or similar)
convert \
    -delay 200 \
        out/app_ui/map-drones-r?.png \
    -loop 0 \
    out/drone-map.gif

convert \
    -delay 200 \
        out/app_ui/nav-r?.png \
        out/app_ui/nav-r2.png \
    -loop 0 \
    out/drone-details.gif