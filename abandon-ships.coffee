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

        # mark as trackable
        if vessel.DISCOVERY
            vessel.DISCOVERY.state = 1
        else
            vessel.DISCOVERY = {
                "state": "1",
                "lastObservedTime": "0",
                "lifetime": "Infinity",
                "refTime": "Infinity",
                "size": "2"
            }

    return save
