#!/usr/bin/env bash
# script to backup Pi SD card
# Localiza el disco con una partición linux (como la de Raspbian)


export DSK=`diskutil list | grep "Linux" | cut -c 69-73`
if [ $DSK ]; then
    echo $DSK
else
    echo "Disk not found"
    exit
fi

diskutil unmountDisk /dev/$DSK

echo Por favor, espere. Esto toma algún tiempo
# requiere el comando PV. Sino, puede des-comentar las lineas de abajo y comente la que contiene pv
#echo Ctl+T para ver el progreso
#time sudo dd if=/dev/r$DSK bs=1m | gzip -9 > ~/Desktop/Piback.img.gz
time sudo dd if=/dev/r$DSK bs=1m | pv | gzip -9 > ~/Desktop/Piback.img.gz

# Renombrar el backup a la fecha actual
echo Compresion completa - Ahora renombramos

mv -n ~/Desktop/Piback.img.gz ~/Desktop/Piback$(date +%Y%m%d%H%M%S).img.gz