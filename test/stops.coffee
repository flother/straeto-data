_ = require 'underscore'
stops = require '../lib/stops'

describe 'Stop Importer', ->
    it 'defaults', (done) ->
        stops.importDefault (err, stops) ->
            expect(stops).to.be.an.object

            stop = (_ stops.features).find (s) -> s.properties.stopId is '90000270'

            expect(stop).to.deep.equal {
                type: "Feature"
                properties:
                    stopId: '90000270'
                    longName: 'Menntaskólinn við Hamrahlíð / MH'
                    shortName: 'MH'
                geometry:
                    type: "Point"
                    coordinates: [
                        -21.9072679997438
                        64.131307999805
                    ]
            }

            done()
