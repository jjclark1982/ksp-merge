#!/usr/bin/env bash

rm saves/merged* saves/persistent.sfs

for F in saves/*.sfs; do
    ./sfs2json < $F > $F.json
    ./abandon-ships < $F.json > $F.derelict.json
done

./merge-saves saves/0.24.sfs.json saves/*derelict* > saves/merged.json

./json2sfs < saves/merged.json > saves/persistent.sfs

rm saves/*.json
