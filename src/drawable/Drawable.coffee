# Represents a common Drawable. This class might be overridden as it is useless
# here as it is
class Rotten.Drawable


    # Constructs your drawable
    constructor: ->


    # Setup your drawable (optional)
    setup: ->
        console.warn "[Rotten.Drawable] Your drawable may override setup() method. It is not required, but strongly advised if you don't use class/constructor logic."


    # Update your drawable (required)
    update: ->
        throw new Error "[Rotten.Drawable] Your drawable should override update() method."


    # Draw your drawable (required)
    draw: ->
        throw new Error "[Rotten.Drawable] Your drawable should override draw() method."
