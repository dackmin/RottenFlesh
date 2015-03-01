# Default overridable Engine class
class Rotten.Engine

    # Canvas render
    @CANVAS = 0

    # WebGL2D render
    @WEBGL = 1


    # Constructs a new graphical engine
    #
    # @param {String} view HTLM tag of an existing canvas
    constructor: (view) ->
        if not view
            @view = document.createElement "canvas"
            @view.style.position = "absolute"
            @view.style.top = "0px"
            @view.style.left = "0px"
            @view.width = Rotten.Utils.screenWidth()
            @view.height = Rotten.Utils.screenHeight()
            document.body.appendChild @view
        else
            @view = view

        @width = @view.width
        @height = @view.height


    # Get the current drawing context
    #
    # @return {Object} The current context
    getContext: ->
        throw new Error "[Rotten.Engine] Your render should override getContext() method"


    # Get render width
    # @return {int} Render width
    getWidth: ->
        @width


    # Get render height
    # @return {int} Render height
    getHeight: ->
        @height


    # Set context background color
    #
    # @param {String} color Hex color or keyword
    setBackgroundColor: (color) ->
        throw new Error "[Rotten.Engine] Your render should override setBackgroundColor() method"


    # Clear a given zone
    #
    # @param {int} x X position of cleaning rectangle
    # @param {int} y Y position of cleaning rectangle
    # @param {int} width Width of cleaning rectangle
    # @param {int} height Height of cleaning rectangle
    clearRect: (x, y, width, height) ->
        throw new Error "[Rotten.Engine] Your render should override clearRect() method"


    # Save current context
    save: ->
        throw new Error "[Rotten.Engine] Your render should override save() method"


    # Restore saved context
    restore: ->
        throw new Error "[Rotten.Engine] Your render should override restore() method"


    # Translate whole current context
    #
    # @param {int} x X translation value
    # @param {int} y Y translation value
    translate: (x,y) ->
        throw new Error "[Rotten.Engine] Your render should override translate() method"


    # Rotate whole current context
    #
    # @param {int} angle Degrees angle
    rotate: (angle) ->
        throw new Error "[Rotten.Engine] Your render should override rotate() method"


    # Set alpha for current context
    #
    # @param {float} alpha Alpha value (from .0 to 1.0)
    setAlpha: (alpha) ->
        throw new Error "[Rotten.Engine] Your render should override setAlpha() method"


    # Draw an image on context
    #
    # @param {Image} image The image you want to draw
    # @param {int} x X position of your image
    # @param {int} y Y position of your image
    # @param {int} width Width of your image
    # @param {int} height Height of your image
    drawImage: (image, x, y, width, height)->
        throw new Error "[Rotten.Engine] Your render should override drawImage() method"


    # Draw a clipped image on context
    #
    # @param {Image} image Image you want to draw
    # @param {int} sub_x X position of clipping rectangle on image
    # @param {int} sub_y Y position of clipping rectangle on image
    # @param {int} sub_width Width of clipping rectangle on image
    # @param {int} sub_height Height of clipping rectangle on image
    # @param {int} x X position of clipped image on context
    # @param {int} y Y position of clipped image on context
    # @param {int} width Width of clipped image
    # @param {int} height Height of clipped image
    drawSubImage: (image, sub_x, sub_y, sub_width, sub_height, x, y, width, height) ->
        throw new Error "[Rotten.Engine] Your render should override drawSubImage() method"


    # Used to begin a path in context
    beginPath: ->
        throw new Error "[Rotten.Engine] Your render should override beginPath() method"


    # Used to clip a region defined by a path
    clip: ->
        throw new Error "[Rotten.Engine] Your render should override clip() method"


    # Draw an arc (commonly used to draw circles)
    #
    # @param {int} centerX X position of the center of your arc
    # @param {int} centerY Y position of the center of your arc
    # @param {float} radius Your arc radius
    # @param {int} startingAngle Radian angle on a circle where to draw your arc
    # @param {int} endAngle Radian angle where to finish your angle
    # @param {boolean} counterClockwise Optional. Specifies whether the drawing
    #                   should be counterclockwise or clockwise. False is
    #                   default, and indicates clockwise, while true indicates
    #                   counter-clockwise.
    arc: (centerX, centerY, radius, startingAngle, endAngle, counterClockwise) ->
        throw new Error "[Rotten.Engine] Your render should override arc() method"


    # Draw a rectangle
    #
    # @param {int} x X position of your rectangle
    # @param {int} y Y position of your rectangle
    # @param {int} width Width of your rectangle
    # @param {int} height Height of your rectangle
    rect: (x, y, width, height) ->
        throw new Error "[Rotten.Engine] Your render should override rect() method"
