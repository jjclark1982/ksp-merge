#!/usr/bin/env bash

rm saves/merged*

for F in saves/*.sfs; do
    ./sfs2json.coffee < $F > $F.json
    ./abandon-ships.coffee < $F.json > $F.derelict.json
done

./merge-saves.coffee saves/0.24.sfs.json saves/*derelict* > saves/merged.json

./json2sfs.coffee < saves/merged.json > saves/merged.sfs

rm saves/*.json
