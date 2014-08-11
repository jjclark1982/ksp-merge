#!/usr/bin/env coffee

# move vessels between saves
# usage: $0 main.json 1.json 2.json 3.json > merged.json

sysPath = require("path")

ensureArray = (thing)->
    return thing if thing instanceof Array
    return [thing]


seenPids = {}
count = 0
mergeSaves = (main, alt)->
    mainVessels = ensureArray(main.GAME.FLIGHTSTATE.VESSEL)
    main.GAME.FLIGHTSTATE.VESSEL = mainVessels
    if Object.keys(seenPids).length is 0
        for vessel in mainVessels
            seenPids[vessel.pid] = vessel

    for vessel in ensureArray(alt.GAME.FLIGHTSTATE.VESSEL)
        unless seenPids[vessel.pid]
            mainVessels.push(vessel)
            count++


merged = null
for arg in process.argv.slice(2)
    file = sysPath.resolve(arg)
    save = require(file)
    if merged is null
        merged = save
    else
        mergeSaves(merged, save)

process.stderr.write("added #{count} vessels to #{process.argv[2]}\n")
process.stdout.write(JSON.stringify(merged, null, '  '))
