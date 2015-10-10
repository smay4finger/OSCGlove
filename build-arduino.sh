#!/bin/sh

SKETCHBOOK=$(dirname $0)/Arduino
SKETCH=$1

if [ -z "${SKETCH}" ] ; then
    SKETCH=OSCGlove
fi

exec arduino --upload --board arduino:avr:flora8 ${SKETCHBOOK}/${SKETCH}/${SKETCH}.ino
