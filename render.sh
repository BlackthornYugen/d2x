#!/usr/bin/env bash
set -e
SRC_FOLDER="$PWD"
PLANT_JAR="$PWD/plantuml.jar"
PLANT_URL="http://sourceforge.net/projects/plantuml/files/plantuml.1.2020.26.jar/download"
PLANT_HASH="504dd55fb8884088f374c07753689a3c5a4bd7f9e6ac16cc93146f5c4e530fcd"

# Prereq: PlantUML Jar
wget --no-clobber --output-document=${PLANT_JAR} $PLANT_URL || true # don't abort on wget fail
sha256sum --check <<< "${PLANT_HASH} plantuml.jar" # Abort if hashcheck fails

#cleanup
find . -regextype sed -regex ".*\.\(png\|svg\|gif\)" -ls -delete

for file in *.pu ; do
 WORKING_FOLDER=out/${file%.*}
 mkdir -vp ${WORKING_FOLDER}
 pushd ${WORKING_FOLDER}
 cp ${SRC_FOLDER}/${file} $file
 java -jar ${PLANT_JAR} ${file}
 rm $file
 popd
done

# Prereq: Imagemagic for gif
# yum install ImageMagick (or similar)
convert -delay 100 out/app_ui/map*.png -loop 0 out/movie.gif
