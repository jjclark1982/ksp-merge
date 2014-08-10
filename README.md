# KSP-merge

A collection of utilities for working with Kerbal Space Program SFS files.

My main goal is to extract vessels from old or foreign saves, remove their crew and fuel, and add them to an existing save as derelicts.

### Utilities

`sfs2json.coffee` - convert an SFS file to JSON

`json2sfs.coffee` - convert a JSON file to SFS

`abandon-ships.coffee` - remove crew and fuel from a JSON file

`merge-saves.coffee` - add vessels from many saves to a main save, unless the main save already has a vessel with the same pid

### Example

    ./sfs2json.coffee < old.sfs | ./abandon-ships.coffee > old-derelicts.json
    ./sfs2json.coffee < new.sfs > new.json
    ./merge-saves.coffee new.json old-derelicts.json | ./json2sfs.coffee > merged.sfs
