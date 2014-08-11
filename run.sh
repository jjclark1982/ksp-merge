#!/usr/bin/env bash

rm saves/merged*

for F in saves/*.sfs; do
    ./sfs2json < $F > $F.json
    ./abandon-ships < $F.json > $F.derelict.json
done

./merge-saves saves/0.24.sfs.json saves/*derelict* > saves/merged.json

./json2sfs < saves/merged.json > saves/merged.sfs

rm saves/*.json
