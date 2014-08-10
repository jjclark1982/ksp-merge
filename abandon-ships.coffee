#!/usr/bin/env coffee

# remove crew and fuel from vessels
# usage: $0 < persistent.json > derelicts.json

data = ''
count = 0
process.stdin.on("data", (chunk)->
    data += chunk
)
process.stdin.on("end", ->
    save = JSON.parse(data)
    data = null
    processVessels(save)
    process.stdout.write(JSON.stringify(save, null, '  '))
    console.error("processed #{count} ships")
)

ensureArray = (thing)->
    return thing if thing instanceof Array
    return [thing]

vesselSize = (partCount)->
    Math.floor(Math.min(4, Math.log(partCount)/Math.log(5)))

processVessels = (save)->
    return unless save?.GAME?.FLIGHTSTATE?.VESSEL
    vessels = ensureArray(save.GAME.FLIGHTSTATE.VESSEL)
    save.GAME.FLIGHTSTATE.VESSEL = vessels
    for vessel in vessels
        count++
        parts = ensureArray(vessel.PART)
        vessel.PART = parts
        for part in parts
            # remove crew
            delete part.crew

            # remove fuel
            if part.RESOURCE
                resources = ensureArray(part.RESOURCE)
                for resource in resources
                    resource.amount = 0
                part.RESOURCE = resources

        if vessel.type isnt 'Debris'
            # mark as trackable
            vessel.DISCOVERY ?= {}
            vessel.DISCOVERY.lastObservedTime ?= 0
            vessel.DISCOVERY.lifetime ?= "Infinity"
            vessel.DISCOVERY.refTime ?= "Infinity"
            vessel.DISCOVERY.state = 1
            vessel.DISCOVERY.size = vesselSize(parts.length)

    return save
