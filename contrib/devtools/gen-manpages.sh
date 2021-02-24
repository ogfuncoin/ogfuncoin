#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

OGFUNCOIND=${OGFUNCOIND:-$BINDIR/ogfuncoind}
OGFUNCOINCLI=${OGFUNCOINCLI:-$BINDIR/ogfuncoin-cli}
OGFUNCOINTX=${OGFUNCOINTX:-$BINDIR/ogfuncoin-tx}
OGFUNCOINQT=${OGFUNCOINQT:-$BINDIR/qt/ogfuncoin-qt}

[ ! -x $OGFUNCOIND ] && echo "$OGFUNCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
OGFCVER=($($OGFUNCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for ogfuncoind if --version-string is not set,
# but has different outcomes for ogfuncoin-qt and ogfuncoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$OGFUNCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $OGFUNCOIND $OGFUNCOINCLI $OGFUNCOINTX $OGFUNCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${OGFCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${OGFCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
