class Rotten.Scene

    constructor: (@game) ->
        @objects = []

    setup: () ->
        object.setup() for object in @objects

    update: () ->
        object.update() for object in @objects

    draw: () ->
        object.draw() for object in @objects
