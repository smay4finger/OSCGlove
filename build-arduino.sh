#!/bin/sh

SKETCHBOOK=$(dirname $0)/Arduino
SKETCH=$1

if [ -z "${SKETCH}" ] ; then
    SKETCH=OSCGlove
fi

exec arduino --upload --board arduino:avr:micro --pref sketchbook.path=${SKETCHBOOK} ${SKETCHBOOK}/${SKETCH}/${SKETCH}.ino
