# An actual Game scene : Everything happens here
# Can be a config screen, a start screen, or your whole game scene
#
# @example How to create a new scene
#   var scene = new Rotten.Scene();
#
# @example How to add stuff to your scene
#   scene.addExisting({Rotten.Drawables});
#
class Rotten.Scene


    # Constructs your scene
    # @param {Rotten.Game} game Your current game
    constructor: (@game) ->

        # Objects in your scene
        @objects = []


    # All your setup logic should go here (adding objects to scene, ...)
    setup: ->
        object.setup() for object in @objects


    # All your update logic should go here (moving objects, ...)
    update: ->
        object.update() for object in @objects


    # All your draw logic should be here (draw objects, draw shit, ...)
    draw: ->
        object.draw() for object in @objects


    addExisting: (object, unique) ->
        @objects.push object if unique and @objects.indexOf object == -1
