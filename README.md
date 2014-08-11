# KSP-merge

A collection of utilities for working with Kerbal Space Program SFS files.

My main goal is to extract vessels from old or foreign saves, remove their crew and fuel, and add them to an existing save as derelicts.

### Utilities

`sfs2json` - convert an SFS file to JSON

`json2sfs` - convert a JSON file to SFS

`abandon-ships` - remove crew and fuel from a JSON file

`merge-saves` - add vessels from many saves to a main save, unless the main save already has a vessel with the same pid

### Example

    ./sfs2json < old.sfs | ./abandon-ships > old-derelicts.json
    ./sfs2json < new.sfs > new.json
    ./merge-saves new.json old-derelicts.json | ./json2sfs > merged.sfs
