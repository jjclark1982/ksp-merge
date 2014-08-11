#!/usr/bin/env coffee

# convert JSON to SFS
# usage: $0 < persistent.json > persistent.sfs

data = ''
count = 0
process.stdin.on("data", (chunk)->
    data += chunk
)
process.stdin.on("end", ->
    object = JSON.parse(data)
    data = null
    printSFS(object)
    process.stderr.write("serialized #{count} groups\n")
)

classOf = (thing)->
    match = toString.call(thing).match(/\[object (.*)\]/)
    if match
        return match[1]
    else
        return 'unknown'

printSFS = (object, indent='')->
    for key, value of object
        switch classOf(value)
            when "Object"
                count++
                # recursively print each item in this group
                process.stdout.write("#{indent}#{key}\r\n#{indent}{\r\n")
                printSFS(value, indent+"\t")
                process.stdout.write(indent + "}\r\n")

            when "Array"
                # sequentially print each item with this key
                for v in value
                    obj = {}
                    obj[key] = v
                    printSFS(obj, indent)

            else
                # print a plain key and value
                process.stdout.write("#{indent}#{key} = #{value}\r\n")
