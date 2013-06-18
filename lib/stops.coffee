fs = require 'fs'
csv = require 'csv'

parseCsv = (csv, callback) ->
    stops =
      type: "FeatureCollection"
      features: []

    csv
        .on('record', (row, index) ->
            return if index is 0 and row[0] is 'stopId'


            [stopId, longName, shortName, latitude, longitude] = row
            stops.features.push {
                type: "Feature"
                properties:
                    stopId: stopId
                    longName: longName
                    shortName: shortName
                geometry:
                    type: "Point"
                    coordinates: [
                        (Number longitude)
                        (Number latitude)
                    ]
            }
        )
        .on('error', (err) -> callback err)
        .on('end', (count) -> callback null, stops)

@importCsv = (string, callback) ->
    parseCsv csv().from(string), callback

@importCsvStream = (stream, callback) ->
    parseCsv csv().from.stream(stream), callback

@importDefault = (callback) ->
    stream = fs.createReadStream "#{__dirname}/../stops/allStops.csv"
    @importCsvStream stream, callback
