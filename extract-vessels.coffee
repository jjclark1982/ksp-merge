#!/usr/bin/env coffee

# dumb parser that simply snips vessel files out of an SFS
# usage: extract-vessels.coffee < persistent.sfs > derelicts.sfs
# vessels go in GAME > FLIGHTSTATE > VESSEL

split = require("split")

lines = process.stdin.pipe(split())

vessels = []
currentVessel = null
depth = 0
prevLine = null
group = null
lines.on("data", (line)->
    if line.match(/\bVESSEL\b/)
        currentVessel = ''
        depth = 0
    if currentVessel isnt null
        if line.match(/crew =/)
            # remove crew
            return
        if line.match(/amount =/)
            # remove all kinds of fuel
            line = line.replace(/amount = (.*)/, "amount = 0")
        if line.match(/state =/) and group is "DISCOVERY"
            # treat it as undiscovered
            line = line.replace(/state = (.*)/, "state = 1")
        currentVessel += line + '\n'
        if line.match(/\{/)
            depth++
            group = prevLine.trim()
        if line.match(/\}/)
            depth--
            if depth is 0
                vessels.push(currentVessel)
                currentVessel = null
                group = null
    prevLine = line
)

lines.on("end", ->
    process.stderr.write("#{vessels.length} vessels\n")
    for vessel in vessels
        process.stdout.write(vessel)
)
