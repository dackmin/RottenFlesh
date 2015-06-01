###*
 # An actual Game scene : Everything happens here
 # Can be a config screen, a start screen, or your whole game scene
 # @class Rotten.Scene
 #
 # @example How to create a new scene
 #   var scene = new Rotten.Scene();
 #
 # @example How to add stuff to your scene
 #   scene.addExisting({Rotten.Drawable});
 #
###
class Rotten.Scene


    ###*
     # Constructs your scene
     # @constructor
     # @param {Rotten.Game} game Your current game
     # @param {Object} custom Object having setup, update & draw methods
    ###
    constructor: (@game, @custom) ->

        # Objects in your scene
        @objects = []


    ###*
     # All your setup logic should go here (adding objects to scene, ...)
     # @method setup
    ###
    setup: () ->
        @custom.setup @ if @custom and @custom.setup
        object.setup() for object in @objects


    ###*
     # All your update logic should go here (moving objects, ...)
     # @method update
    ###
    update: () ->
        @custom.update @ if @custom and @custom.update
        object.update() for object in @objects


    ###*
     # All your draw logic should be here (draw objects, draw shit, ...)
     # @method draw
    ###
    draw: () ->
        @custom.draw @ if @custom and @custom.draw
        object.draw() for object in @objects


    ###*
     # Add an existing object to your scene
     # @method addExisting
     # @param {Object} object - The thing you want to add to your scene
     # @param {boolean} unique - Whether you want to avoid duplicated objects
    ###
    addExisting: (object, unique) ->
        object.game = @game

        if unique
            @objects.push object if @objects.indexOf object == -1
        else
            @objects.push object
