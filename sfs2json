#!/usr/bin/env coffee

# convert SFS file to JSON
# usage: $0 < persistent.sfs > persistent.json

split = require("split")

file = {}
cursor = [file]
count = 0

lines = process.stdin.pipe(split())
lines.on("data", (line)->
    head = cursor[cursor.length-1]
    match = line.match(/(.*)=(.*)/)
    if match
        # plain key and value
        key = match[1].trim()
        value = match[2].trim()
    else if line.match(/\{/)
        null
    else if line.match(/\}/)
        cursor.pop()
    else if line.match(/\w/)
        # key for a group. create an empty object to hold the value
        key = line.trim()
        value = {}
        cursor.push(value)
        count++

    if key
        existing = head[key]
        if existing
            # store duplicate keys as an array as soon as we see the second one
            head[key] = [existing] unless existing instanceof Array
            head[key].push(value)
        else
            head[key] = value
)

lines.on("end", ->
    process.stderr.write("parsed #{count} groups\n")
    process.stdout.write(JSON.stringify(file, null, "  "))
)
