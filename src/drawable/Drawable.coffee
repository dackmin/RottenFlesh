###*
 # Represents a common Drawable. This class might be overridden as it is useless
 # here as it is
 # @class Rotten.Drawable
###
class Rotten.Drawable


    ###*
     # Constructs your drawable
     # @constructor
    ###
    constructor: () ->


    ###*
     # Setup your drawable (optional)
     # @method setup
    ###
    setup: () ->
        console.warn "[Rotten.Drawable]", "Your drawable may override setup() method. It is not required, but strongly advised if you don't use class/constructor logic."


    ###*
     # Update your drawable (required)
     # @method update
    ###
    update: () ->
        throw new Error "[Rotten.Drawable] Your drawable should override update() method."


    ###*
     # Draw your drawable (required)
     # @method draw
    ###
    draw: () ->
        throw new Error "[Rotten.Drawable] Your drawable should override draw() method."
